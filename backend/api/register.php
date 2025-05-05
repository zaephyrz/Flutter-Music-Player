<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once 'db_connect.php';

$response = ['success' => false, 'message' => ''];

$input = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (empty($input['username']) || empty($input['email']) || empty($input['password'])) {
        $response['message'] = "All fields are required";
        http_response_code(400);
        echo json_encode($response);
        exit;
    }

    $username = trim($input['username']);
    $email = trim($input['email']);
    $password = trim($input['password']);

    // Check if user exists
    $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
    $stmt->execute([$email]);
    
    if ($stmt->rowCount() > 0) {
        $response['message'] = "Email already registered";
        http_response_code(400);
        echo json_encode($response);
        exit;
    }

    // Hash password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // Insert new user
    $stmt = $pdo->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
    if ($stmt->execute([$username, $email, $hashedPassword])) {
        $response['success'] = true;
        $response['message'] = "User registered successfully";
        http_response_code(200);
    } else {
        $response['message'] = "Registration failed";
        http_response_code(500);
    }
} else {
    $response['message'] = "Invalid request method";
    http_response_code(405);
}

echo json_encode($response);
?>