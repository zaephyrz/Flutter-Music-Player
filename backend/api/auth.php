<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Force JSON response even for errors
function jsonResponse($success, $message, $data = null) {
    http_response_code($success ? 200 : 400);
    die(json_encode([
        'success' => $success,
        'message' => $message,
        'data' => $data
    ]));
}

try {
    // Verify POST request
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        jsonResponse(false, 'Only POST requests allowed');
    }

    // Get and validate JSON input
    $input = json_decode(file_get_contents('php://input'), true);
    if (json_last_error() !== JSON_ERROR_NONE) {
        jsonResponse(false, 'Invalid JSON: ' . json_last_error_msg());
    }

    require_once 'db_connect.php';

    switch ($input['action'] ?? '') {
        case 'register':
            // Validate registration data
            $required = ['username', 'email', 'password'];
            foreach ($required as $field) {
                if (empty($input[$field])) {
                    jsonResponse(false, "$field is required");
                }
            }

            $email = strtolower(trim($input['email']));
            $username = trim($input['username']);
            $password = trim($input['password']);

            // Check if user exists
            $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
            $stmt->execute([$email]);
            if ($stmt->rowCount() > 0) {
                jsonResponse(false, 'Email already registered');
            }

            // Hash password and insert user
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
            if (!$stmt->execute([$username, $email, $hashedPassword])) {
                jsonResponse(false, 'Registration failed');
            }

            // Return success with user ID as string to avoid Dart int conversion issues
            jsonResponse(true, 'Registration successful', [
                'user' => [
                    'id' => strval($pdo->lastInsertId()), // Convert to string
                    'username' => $username,
                    'email' => $email
                ]
            ]);
            break;

        case 'login':
            // Login implementation here
            break;

        default:
            jsonResponse(false, 'Invalid action');
    }
} catch (Exception $e) {
    jsonResponse(false, 'Server error: ' . $e->getMessage());
}
?>