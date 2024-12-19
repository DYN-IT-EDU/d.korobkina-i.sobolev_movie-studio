const cds = require("@sap/cds");
class EquipmentService extends cds.ApplicationService {
  init() {
    this.on("showLowStock", this.showLowStock);
    this.on("OrderEquipment", this.PlaceOrder);
    return super.init();
  }

  async showLowStock() {
    const { Equipment } = this.entities;
    const b = await SELECT.from(Equipment).where({ quantity: { "<=": 10 } });

    return b;
  }
  async PlaceOrder(req) {
    const { Equipment } = this.entities;
    const { item, order } = req.data;
    console.log("item", item, "order", order);
    if (order < 1) {
      return req.error("Quantity must be greater than 0");
    }
    const itemInStock = await SELECT.one.from(Equipment).where({ ID: item });
    if (!itemInStock) {
      return req.error("Item not found");
    }
    let { quantity } = itemInStock;
    if (order > quantity) {
      return req.error("Not enough stock", [order, quantity, itemInStock]);
    }

    await UPDATE(Equipment)
      .set({ quantity: quantity - order })
      .where({ ID: item });
    return { quantity: quantity - order };
  }
}

module.exports = EquipmentService;
