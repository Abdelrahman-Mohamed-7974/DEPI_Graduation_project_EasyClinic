import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "easy_clinic.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // 1. Create users table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        password TEXT,
        phone TEXT,
        birth_date TEXT,
        profile_image TEXT
      )
    ''');

    // 2. Create doctors table
    await db.execute('''
      CREATE TABLE doctors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        specialization TEXT,
        rating REAL,
        number_of_reviews INTEGER,
        experience_years INTEGER,
        working_hours TEXT,
        profile_description TEXT,
        career_path TEXT,
        highlights TEXT,
        image TEXT,
        is_favorite INTEGER
      )
    ''');

    // 3. Create favorites table
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        doctor_id INTEGER,
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (doctor_id) REFERENCES doctors (id)
      )
    ''');

    // 4. Create appointments table
    await db.execute('''
      CREATE TABLE appointments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        doctor_id INTEGER,
        user_id INTEGER,
        date TEXT,
        time TEXT,
        status TEXT,
        FOREIGN KEY (doctor_id) REFERENCES doctors (id),
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // 5. Create notifications table
    await db.execute('''
      CREATE TABLE notifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        title TEXT,
        message TEXT,
        date TEXT,
        is_read INTEGER,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // 6. Create conversations table
    await db.execute('''
      CREATE TABLE conversations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        doctor_id INTEGER,
        last_message TEXT,
        date TEXT,
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (doctor_id) REFERENCES doctors (id)
      )
    ''');

    // 7. Create messages table
    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        conversation_id INTEGER,
        sender_id INTEGER,
        text TEXT,
        time TEXT,
        FOREIGN KEY (conversation_id) REFERENCES conversations (id)
      )
    ''');

    // 8. Create payment_cards table
    await db.execute('''
      CREATE TABLE payment_cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        card_holder_name TEXT,
        card_number TEXT,
        expiry_date TEXT,
        cvv TEXT,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // 9. Create settings table
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        notifications_enabled INTEGER,
        dark_mode_enabled INTEGER,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // SEED INITIAL DATA
    await _seedDemoData(db);
  }

  Future<void> _seedDemoData(Database db) async {
    // 1. Seed demo user
    await db.insert('users', {
      'id': 1,
      'name': 'John Doe',
      'email': 'john@example.com',
      'password': '123456',
      'phone': '+201111111111',
      'birth_date': '01/01/2000',
      'profile_image':
          'assets/profile_placeholder.png', // Or appropriate local asset
    });

    // 2. Seed Settings for Demo User
    await db.insert('settings', {
      'user_id': 1,
      'notifications_enabled': 1,
      'dark_mode_enabled': 0,
    });

    // 3. Seed Doctors
    final doctors = [
      {
        'id': 1,
        'name': 'Dr. Marcus Horizon',
        'specialization': 'Cardiologist',
        'rating': 4.8,
        'number_of_reviews': 120,
        'experience_years': 10,
        'working_hours': '09:00 AM - 05:00 PM',
        'profile_description':
            'Dr. Marcus Horizon is a top cardiologist in the city. He has over 10 years of experience in performing successful heart surgeries.',
        'career_path': 'Senior Cardiologist at City Hospital',
        'highlights': 'Awarded Best Doctor of the Year 2021',
        'image': 'assets/doctor1.png',
        'is_favorite': 0,
      },
      {
        'id': 2,
        'name': 'Dr. Alysa Hana',
        'specialization': 'Dermatologist',
        'rating': 4.7,
        'number_of_reviews': 85,
        'experience_years': 8,
        'working_hours': '10:00 AM - 04:00 PM',
        'profile_description':
            'Dr. Alysa Hana is a highly rated dermatologist known for her careful treatments of skin issues.',
        'career_path': 'Lead Dermatologist at SkinCare Center',
        'highlights': 'Specializes in laser treatments',
        'image': 'assets/doctor2.png',
        'is_favorite': 0,
      },
      {
        'id': 3,
        'name': 'Dr. John Smith',
        'specialization': 'Pediatrician',
        'rating': 4.9,
        'number_of_reviews': 150,
        'experience_years': 12,
        'working_hours': '08:00 AM - 02:00 PM',
        'profile_description': 'Friendly and experienced pediatrician.',
        'career_path': 'Pediatrician at Children Health Clinic',
        'highlights': 'Specialist in child care and vaccination',
        'image': 'assets/doctor3.png',
        'is_favorite': 0,
      },
      {
        'id': 4,
        'name': 'Dr. Emily Davis',
        'specialization': 'Orthopedic',
        'rating': 4.6,
        'number_of_reviews': 95,
        'experience_years': 7,
        'working_hours': '11:00 AM - 06:00 PM',
        'profile_description': 'Expert in bone surgeries and orthopedics.',
        'career_path': 'Orthopedic Surgeon at General Hospital',
        'highlights': 'Extensive experience in knee replacements',
        'image': 'assets/doctor4.png',
        'is_favorite': 0,
      },
      {
        'id': 5,
        'name': 'Dr. Sarah Wilson',
        'specialization': 'Neurologist',
        'rating': 4.8,
        'number_of_reviews': 110,
        'experience_years': 15,
        'working_hours': '09:00 AM - 03:00 PM',
        'profile_description':
            'Highly specialized neurologist dealing with complex brain conditions.',
        'career_path': 'Chief of Neurology at Central Hospital',
        'highlights': 'Researcher in advanced neurological diseases',
        'image': 'assets/doctor1.png',
        'is_favorite': 0,
      },
      {
        'id': 6,
        'name': 'Dr. Michael Brown',
        'specialization': 'Dentist',
        'rating': 4.5,
        'number_of_reviews': 75,
        'experience_years': 5,
        'working_hours': '12:00 PM - 08:00 PM',
        'profile_description':
            'Professional dentist focused on cosmetic and general dentistry.',
        'career_path': 'Dentist at Bright Smiles Clinic',
        'highlights': 'Specializes in cosmetic dentistry',
        'image': 'assets/doctor2.png',
        'is_favorite': 0,
      },
    ];

    for (var doc in doctors) {
      await db.insert('doctors', doc);
    }

    // 4. Seed Payment Cards
    await db.insert('payment_cards', {
      'id': 1,
      'user_id': 1,
      'card_holder_name': 'John Doe',
      'card_number': '**** **** **** 1234',
      'expiry_date': '12/25',
      'cvv': '***',
    });

    // 5. Seed Appointments
    await db.insert('appointments', {
      'id': 1,
      'doctor_id': 1,
      'user_id': 1,
      'date': '2025-10-15',
      'time': '10:00 AM',
      'status': 'Upcoming',
    });

    // 6. Seed Notifications
    await db.insert('notifications', {
      'id': 1,
      'user_id': 1,
      'title': 'Appointment Confirmed',
      'message': 'Your appointment with Dr. Marcus Horizon is confirmed.',
      'date': '2025-10-10 09:00 AM',
      'is_read': 0,
    });

    // 7. Seed Conversations & Messages
    await db.insert('conversations', {
      'id': 1,
      'user_id': 1,
      'doctor_id': 1,
      'last_message': 'See you on Monday!',
      'date': '2025-10-10 10:30 AM',
    });

    await db.insert('messages', {
      'id': 1,
      'conversation_id': 1,
      'sender_id': 1, // 1 for user
      'text': 'Hello Doctor, is my test result ready?',
      'time': '10:25 AM',
    });

    await db.insert('messages', {
      'id': 2,
      'conversation_id': 1,
      'sender_id':
          2, // treating doctor's id basically, let's just say 2 for doctor
      'text': 'Yes, everything looks good. See you on Monday!',
      'time': '10:30 AM',
    });
  }
}
