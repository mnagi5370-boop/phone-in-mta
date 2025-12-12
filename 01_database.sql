CREATE TABLE players_phone (
    player_id INT PRIMARY KEY,
    phone_number VARCHAR(10) UNIQUE,
    sim_active BOOLEAN DEFAULT 0,
    sms_balance INT DEFAULT 0,
    call_balance INT DEFAULT 0,
    settings TEXT DEFAULT '{}',
    inventory TEXT DEFAULT '{}'
);
