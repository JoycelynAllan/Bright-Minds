<?php
require_once 'config.php';

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
    exit;
}

// Get JSON input
$input = json_decode(file_get_contents('php://input'), true);

// Validate input
if (!isset($input['username']) || !isset($input['password'])) {
    echo json_encode(['success' => false, 'message' => 'Missing required fields']);
    exit;
}

$usernameOrEmail = trim($input['username']);
$password = $input['password'];

// Get database connection
$conn = getDBConnection();

// Check if user exists (by username or email)
$stmt = $conn->prepare("SELECT id, username, email, password, avatar, last_login FROM users WHERE username = ? OR email = ?");
$stmt->bind_param("ss", $usernameOrEmail, $usernameOrEmail);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(['success' => false, 'message' => 'Invalid username or password']);
    $stmt->close();
    $conn->close();
    exit;
}

$user = $result->fetch_assoc();
$stmt->close();

// Verify password
if (!password_verify($password, $user['password'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid username or password']);
    $conn->close();
    exit;
}

// Update last login
$updateStmt = $conn->prepare("UPDATE users SET last_login = NOW() WHERE id = ?");
$updateStmt->bind_param("i", $user['id']);
$updateStmt->execute();
$updateStmt->close();

// Generate new session token
$sessionToken = bin2hex(random_bytes(32));
$expiresAt = date('Y-m-d H:i:s', strtotime('+30 days'));
$ipAddress = $_SERVER['REMOTE_ADDR'] ?? '';
$userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';

// Delete old sessions for this user (optional - keep only latest)
$deleteStmt = $conn->prepare("DELETE FROM sessions WHERE user_id = ?");
$deleteStmt->bind_param("i", $user['id']);
$deleteStmt->execute();
$deleteStmt->close();

// Create new session
$sessionStmt = $conn->prepare("INSERT INTO sessions (user_id, session_token, ip_address, user_agent, expires_at) VALUES (?, ?, ?, ?, ?)");
$sessionStmt->bind_param("issss", $user['id'], $sessionToken, $ipAddress, $userAgent, $expiresAt);
$sessionStmt->execute();
$sessionStmt->close();

// Get avatar name
$avatarNames = [
    'owl' => '🦉 Wise Owl',
    'fox' => '🦊 Clever Fox',
    'rabbit' => '🐰 Happy Rabbit'
];

echo json_encode([
    'success' => true,
    'message' => 'Login successful!',
    'user' => [
        'id' => $user['id'],
        'username' => $user['username'],
        'email' => $user['email'],
        'avatar' => $user['avatar'],
        'avatarName' => $avatarNames[$user['avatar']],
        'sessionToken' => $sessionToken,
        'lastLogin' => $user['last_login']
    ]
]);

$conn->close();
?>