<?php
// Disable HTML errors - force JSON only
ini_set('display_errors', 0);
ini_set('log_errors', 1);

// Set headers first - before any output
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

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

    // Get raw input
    $input = file_get_contents('php://input');
    if (empty($input)) {
        jsonResponse(false, 'No data received');
    }

    // Decode JSON
    $data = json_decode($input, true);
    if (json_last_error() !== JSON_ERROR_NONE) {
        jsonResponse(false, 'Invalid JSON: ' . json_last_error_msg());
    }

    require_once 'db_connect.php';

    switch ($data['action'] ?? '') {
        case 'login':
            if (empty($data['email']) || empty($data['password'])) {
                jsonResponse(false, 'Email and password are required');
            }

            $email = strtolower(trim($data['email']));
            $password = trim($data['password']);

            $stmt = $pdo->prepare("SELECT id, username, email, password FROM users WHERE email = ?");
            $stmt->execute([$email]);
            $user = $stmt->fetch();

            if (!$user) {
                jsonResponse(false, 'User not found');
            }

            if (!password_verify($password, $user['password'])) {
                jsonResponse(false, 'Invalid password');
            }

            jsonResponse(true, 'Login successful', [
                'user' => [
                    'id' => (string)$user['id'], // Convert to string
                    'username' => $user['username'],
                    'email' => $user['email']
                ]
            ]);
            break;

        default:
            jsonResponse(false, 'Invalid action');
    }
} catch (Exception $e) {
    jsonResponse(false, 'Server error: ' . $e->getMessage());
}
?>