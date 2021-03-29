const faker = require('faker');
const fs = require('fs');

faker.locale = "pt_BR";

const BASE_QTD = 2000000;
const EXTENDED_QTD = 2100000;
const CITY_QTD = 500;
const INFRACTIONS_QTD = 100;

const formatDateString = (date) => new Date(date).toISOString().slice(0, 19).replace('T', ' ');

const generateArrayOfIds = (numOfIds) => {
    const ids = [];
    for (let index = 1; index < numOfIds; index++) {
        ids.push(index);
    }
    return ids;
}

const generateIds = () => {
    const ids = generateArrayOfIds(BASE_QTD);
    const extendedIds = generateArrayOfIds(EXTENDED_QTD);
    const cityIds = generateArrayOfIds(CITY_QTD);
    const infractionIds = generateArrayOfIds(INFRACTIONS_QTD);
    return { ids, extendedIds, cityIds, infractionIds }
}


const generateCityData = (ids) => ids.map((id) => {
    const cityData = {
        id,
        uf: faker.address.stateAbbr(),
        nome_cidade: faker.address.city()
    }
    return cityData;
})

const generateDriverData = (ids) => ids.map((id) => {
    const driverData = {
        id,
        nome: faker.name.firstName() + ' ' + faker.name.lastName(),
        documento: faker.datatype.number({ min: 10000000000, max: 99999999999 }),
        data_emissao_documento: formatDateString(faker.date.past(30, '2020')),
        id_cidade: faker.datatype.number({ min: 1, max: CITY_QTD - 1 }),
    }
    return driverData;
})

const generatePhoneData = (ids) => ids.map((id) => {
    const phoneData = {
        id,
        id_condutor: faker.datatype.number({ min: 1, max: BASE_QTD - 1 }),
        telefone: faker.phone.phoneNumberFormat(),
    }
    return phoneData;
})

const generateVehicleData = (ids) => ids.map((id) => {
    const phoneData = {
        id,
        placa: faker.vehicle.vin().substring(0, 7),
        marca: faker.vehicle.manufacturer(),
        modelo: faker.vehicle.model(),
        id_condutor: faker.datatype.number({ min: 1, max: BASE_QTD - 1 }),
    }
    return phoneData;
})

const generateInfractionData = (ids) => ids.map((id) => {
    const infractionData = {
        id,
        codigo: faker.random.alphaNumeric(4),
        gravidade: faker.datatype.number({ min: 3, max: 7 }),
        descricao: faker.random.words(3),
    }
    return infractionData;
})



const generateDriverInfractionData = (ids) => ids.map((id) => {
    const infractionData = {
        id,
        id_infracao: faker.datatype.number({ min: 1, max: INFRACTIONS_QTD - 1 }),
        id_condutor: faker.datatype.number({ min: 1, max: BASE_QTD - 1 }),
        data_ocorrencia: formatDateString(faker.date.past(29, '2020')),
        id_cidade: faker.datatype.number({ min: 1, max: CITY_QTD - 1 }),
    }
    return infractionData;
});


const arrayToCSV = (data) => {
    const csv = data.map(row => Object.values(row));
    csv.unshift(Object.keys(data[0]));
    return csv.join('\n');
}

const writeDataFiles = async (inputData, fileName) => {
    try {
        const path = './' + fileName + '.csv'
        await fs.promises.writeFile(path, arrayToCSV(inputData));
    } catch (error) {
        throw new Error(error)
    }
}


const generateData = () => {
    const { ids, extendedIds, cityIds, infractionIds } = generateIds();
    const cityData = generateCityData(cityIds);
    const driverData = generateDriverData(ids);
    const phoneData = generatePhoneData(extendedIds);
    const vehicleData = generateVehicleData(extendedIds);
    const infractionData = generateInfractionData(infractionIds);
    const driverInfractionData = generateDriverInfractionData(extendedIds);


    // console.log({ cityData, driverData, phoneData, vehicleData, infractionData, driverInfractionData });

    writeDataFiles(cityData, 'cityData');
    writeDataFiles(driverData, 'driverData');
    writeDataFiles(phoneData, 'phoneData');
    writeDataFiles(vehicleData, 'vehicleData');
    writeDataFiles(infractionData, 'infractionData');
    writeDataFiles(driverInfractionData, 'driverInfractionData');
}


generateData();