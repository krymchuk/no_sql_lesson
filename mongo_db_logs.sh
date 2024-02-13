# створюємо нову базу даних з назвою gymDatabase
test> use gymDatabase;
switched to db gymDatabase


# створюємо потрібні колекції
gymDatabase> db.createCollection("clients")
{ ok: 1 }
gymDatabase> db.createCollection("memberships")
{ ok: 1 }
gymDatabase> db.createCollection("workouts")
{ ok: 1 }
gymDatabase> db.createCollection("trainers")
{ ok: 1 }


# додаємо запис до колекції clients
gymDatabase> db.clients.insertOne({ name: "Jhon", age: 27, email: "jhon@mail.com"});
{
  acknowledged: true,
  insertedId: ObjectId('65cb29136adb6f74be69034b')
}


# ще декілька записів до колекції clients
gymDatabase> db.clients.insertMany([{ name: "Alice", age: 28, email: "alice@example.com" }, { name: "Bob", age: 40, email: "bob@example.com" }]);
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('65cb29c56adb6f74be69034c'),
    '1': ObjectId('65cb29c56adb6f74be69034d')
  }
}


# додаємо дані до колекції memberships
gymDatabase> db.memberships.insertMany([{ client_id: ObjectId("65cb29136adb6f74be69034b"), start_date: ISODate("2024-01-01"), end_date: ISODate("2024-02-01"), type: "Silver" }, { client_id: ObjectId("65cb29c56adb6f74be69034c"), start_date: ISODate("2024-02-01"), end_date: ISODate("2024-03-01"), type: "Gold" }]);
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('65cb2a5b6adb6f74be69034e'),
    '1': ObjectId('65cb2a5b6adb6f74be69034f')
  }
}


# додаємо дані до колекції workouts
gymDatabase> db.workouts.insertMany([
  { description: "Stretching", description: "In its most basic form, stretching is a natural and instinctive activity; it is performed by humans and many other animals. It can be accompanied by yawning.", difficulty: "Medium" },
  { description: "Squats", description: "A squat is a strength exercise in which the trainee lowers their hips from a standing position and then stands back up.", difficulty: "Easy" },
  { description: "High-Intensity Interval Training", description: "It incorporates several rounds that alternate between several minutes of high intensity movements to significantly increase the heart rate", difficulty: "Hard" },
  { description: "Yoga", description: " Yoga is a mind and body practice that can build strength and flexibility. It may also help manage pain and reduce stress.", difficulty: "Easy" }
]);
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('65cb2b856adb6f74be690350'),
    '1': ObjectId('65cb2b856adb6f74be690351'),
    '2': ObjectId('65cb2b856adb6f74be690352'),
    '3': ObjectId('65cb2b856adb6f74be690353')
  }
}


# додаємо дані до колекції trainers
gymDatabase> db.trainers.insertMany([
  { name: "Zach Galifianakis", specialization: "Weightlifting" },
  { name: "James Corden", specialization: "Pilates" },
  { name: "Alec Baldwin", specialization: "Pilates" },
  { name: "Jack Black", specialization: "Bodybuilding" },
]);
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('65cb2cdd6adb6f74be690354'),
    '1': ObjectId('65cb2cdd6adb6f74be690355'),
    '2': ObjectId('65cb2cdd6adb6f74be690356'),
    '3': ObjectId('65cb2cdd6adb6f74be690357')
  }
}


# Запити

# Знайти всіх клієнтів віком понад 30 років
gymDatabase> db.clients.find({ age: { $gt: 30 } });
[
  {
    _id: ObjectId('65cb29c56adb6f74be69034d'),
    name: 'Bob',
    age: 40,
    email: 'bob@example.com'
  }
]


# Перелічити тренування із середньою складністю
gymDatabase> db.workouts.find({ difficulty: "Medium" });
[
  {
    _id: ObjectId('65cb2b856adb6f74be690350'),
    description: 'In its most basic form, stretching is a natural and instinctive activity; it is performed by humans and many other animals. It can be accompanied by yawning.',
    difficulty: 'Medium'
  }
]
gymDatabase>


# Показати інформацію про членство клієнта з певним client_id
gymDatabase> db.memberships.find({ client_id: ObjectId("65cb29c56adb6f74be69034c") });
[
  {
    _id: ObjectId('65cb2a5b6adb6f74be69034f'),
    client_id: ObjectId('65cb29c56adb6f74be69034c'),
    start_date: ISODate('2024-02-01T00:00:00.000Z'),
    end_date: ISODate('2024-03-01T00:00:00.000Z'),
    type: 'Gold'
  }
]
