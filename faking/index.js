import PocketBase from 'pocketbase';

let userIds = [
    "4bg2p12gqqcrneq",
    "pgwx9q6gemk57vb",
    "o4lr4pn9zwidl8y"
]

let seedTypeIds = [
    "klfch9yk075cmpq",
    "q93aghxz9h1pl7u",
    "fcli3v7obfhrwbt"
]

let apiEndpoint = "https://pocketbase.nospy.fr"

let startDate = new Date("2020-01-01")
let endDate = new Date("2023-02-02")

let fakeDataCount = 1000

let randomDate = function () {
    // from start date to end date
    return new Date(startDate.getTime() + Math.random() * (endDate.getTime() - startDate.getTime()));
}

let randomEndDate = function (startDate) {
    return new Date(startDate.getTime() + Math.random() * 10 * 1000 * 60 * 60 + 60 * 1000);
}

function fakeData() {
    let data = []
    for (let i = 0; i < fakeDataCount; i++) {
        let startDate = randomDate()
        let endDate = randomEndDate(startDate)
        let userId = userIds[Math.floor(Math.random() * userIds.length)]
        let seedType = seedTypeIds[Math.floor(Math.random() * seedTypeIds.length)]
        data.push({
            "user": userId,
            "seed_type": seedType,
            "reward": Math.floor(Math.random() * 100) + 1,
            "time_to_grow": Math.floor((endDate.getTime() - startDate.getTime()) / 60000),
            "started": startDate.toISOString(),
            "ended": endDate.toISOString()
        })
    }
    return data
}

const pb = new PocketBase(apiEndpoint)

for (let data of fakeData()) {
    await pb.collection('tree').create(data)
    console.log("created", data)
}
