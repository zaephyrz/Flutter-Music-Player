<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once 'db_connect.php';

$response = ['success' => false, 'message' => 'Login failed'];

// Get raw POST data
$json = file_get_contents('php://input');
$data = json_decode($json, true);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $data) {
    $email = trim($data['email'] ?? '');
    $password = trim($data['password'] ?? '');

    if (empty($email) || empty($password)) {
        $response['message'] = "Email and password are required";
        http_response_code(400);
        echo json_encode($response);
        exit;
    }

    try {
        // Case-insensitive email search
        $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ? LIMIT 1");
        $stmt->execute([$email]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            $response['message'] = "User not found";
            http_response_code(404);
            echo json_encode($response);
            exit;
        }

        // Verify password
        if (password_verify($password, $user['password'])) {
            $response = [
                'success' => true,
                'message' => 'Login successful',
                'user' => [
                    'id' => $user['id'],
                    'username' => $user['username'],
                    'email' => $user['email']
                ]
            ];
            http_response_code(200);
        } else {
            $response['message'] = "Invalid password";
            http_response_code(401);
        }
    } catch (PDOException $e) {
        $response['message'] = "Database error: " . $e->getMessage();
        http_response_code(500);
    }
} else {
    $response['message'] = "Invalid request";
    http_response_code(400);
}

echo json_encode($response);
?>