const cds = require('@sap/cds');

module.exports = async function (srv) {
    const { Variants } = srv.entities;

    // Получение вариантов ТОЛЬКО для текущего пользователя
    srv.on('READ', 'Variants', async (req) => {
        return await SELECT.from(Variants).where({ user: req.user.id });
    });

    // Сохранение нового варианта
    srv.on('SAVE_VARIANT', async (req) => {
        const { entitySet, variantData } = req.data;
        const user = req.user.id; // Получаем текущего пользователя

        await INSERT.into(Variants).entries({
            ID: cds.utils.uuid(),
            user,
            entitySet,
            variantData: JSON.stringify(variantData)
        });

        return { status: "OK" };
    });

    // Удаление варианта (проверяем, что он принадлежит пользователю)
    srv.on('DELETE_VARIANT', async (req) => {
        const { ID } = req.data;
        await DELETE.from(Variants).where({ ID, user: req.user.id });
        return { status: "DELETED" };
    });
};
