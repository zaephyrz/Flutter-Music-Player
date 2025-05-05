<?php
// Validate input
$required = ['username', 'email', 'password'];
foreach ($required as $field) {
    if (empty($data[$field])) {
        throw new Exception("$field is required");
    }
}

// Process registration
$username = trim($data['username']);
$email = strtolower(trim($data['email']));
$password = trim($data['password']);

// Check if user exists
$stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
$stmt->execute([$email]);
if ($stmt->rowCount() > 0) {
    throw new Exception("Email already registered");
}

// Hash password
$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

// Insert user
$stmt = $pdo->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
if (!$stmt->execute([$username, $email, $hashedPassword])) {
    throw new Exception("Registration failed");
}

// Success
echo json_encode([
    'success' => true,
    'message' => 'Registration successful',
    'user' => [
        'id' => $pdo->lastInsertId(),
        'username' => $username,
        'email' => $email
    ]
]);
?>