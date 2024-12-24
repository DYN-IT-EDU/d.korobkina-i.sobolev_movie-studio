const cds = require("@sap/cds");

class EquipmentService extends cds.ApplicationService {
  init() {
    const { Equipment, EquipmentOrders, MoviesViewWithParameter } =
      this.entities;

    this.before("UPDATE", EquipmentOrders, this.checkOrderStatus);
    this.after("READ", Equipment, this.checkStock);
    this.on("showLowStock", this.showLowStock);
    this.on("OrderEquipment", this.placeOrder);
    this.on("CloseOrder", this.closeOrder);
    this.on("sleep", async () => {
      try {
        let dbQuery = 'Call "sleep"()';
        let result = await cds.run(dbQuery, {});
        cds.log().info(result);
        return true;
      } catch (err) {
        cds.log.error(err);
        return false;
      }
    });
    return super.init();
  }

  async showLowStock() {
    const { Equipment } = this.entities;
    const expr = SELECT.from(Equipment).where({ quantity: { "<=": 10 } });
    const res = await cds.run(expr);
    return res;
  }

  async checkStock(data) {
    for (let item of data) {
      if (item.quantity < 20) {
        item.name += " --- LESS THAN 20 -> ORDER MORE EQUIPMENT! ---";
      }
    }
  }

  async placeOrder(req) {
    const {
      Equipment,
      EquipmentOrders,
      Scenes,
      OrderStatuses,
      EquipmentOrderItem,
    } = this.entities;
    const { items, scene } = req.data;
    let orderScene;
    orderScene = await SELECT.one.from(Scenes).where({ ID: scene });

    if (!orderScene) {
      return req.error("Scene not found");
    }

    let result = [];

    for (let i of items) {
      if (i.quantity < 1) {
        return req.error("Quantity must be greater than 0");
      }
      const itemInStock = await SELECT.one
        .from(Equipment)
        .where({ ID: i.item });
      if (!itemInStock) {
        return req.error(`Item with ID: ${i.item} not found"`);
      }
      let { quantity } = itemInStock;
      if (i.quantity > quantity) {
        return req.error(
          `Not enough stock -  ${i.quantity}, ${quantity}, ${itemInStock.name}`
        );
      }

      await UPDATE(Equipment)
        .set({ quantity: quantity - i.quantity })
        .where({ ID: i.item });

      result.push({
        item: i.item,
        quantity: i.quantity,
        stock: quantity - i.quantity,
      });
    }

    const status = await SELECT.one.from(OrderStatuses).where({ ID: 100 });

    const orderResult = await INSERT.into(EquipmentOrders).entries({
      scene: orderScene,
      status: status,
      date: new Date(),
    });

    const idOfOrder = [...orderResult];

    for (let i of result) {
      await INSERT.into(EquipmentOrderItem).entries({
        equipmentOrder: await SELECT.one
          .from(EquipmentOrders)
          .where({ ID: idOfOrder[0].ID }),
        equipment: await SELECT.one.from(Equipment).where({ ID: i.item }),
        quantity: i.quantity,
      });
    }
    return [result];
  }

  async checkOrderStatus(req) {
    const { ID } = req.data;
    const { EquipmentOrders } = this.entities;
    const currentOrder = await SELECT.one
      .from(EquipmentOrders)
      .where({ ID: ID });
    console.log("currentOrder", currentOrder);
    if (currentOrder.status_ID === 102) {
      return req.reject("Order is already closed");
    }
  }

  async closeOrder(req) {
    const { EquipmentOrders, OrderStatuses } = this.entities;
    const { order } = req.data;
    await UPDATE(EquipmentOrders)
      .set({ status: await SELECT.one.from(OrderStatuses).where({ ID: 102 }) })
      .where({ ID: order });

    return "Order closed";
  }
}

module.exports = EquipmentService;
