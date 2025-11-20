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
if (!isset($input['sessionToken'])) {
    echo json_encode(['success' => false, 'message' => 'Missing session token']);
    exit;
}

$sessionToken = $input['sessionToken'];

// Get database connection
$conn = getDBConnection();

// Verify session
$stmt = $conn->prepare("
    SELECT s.user_id, s.expires_at, u.username, u.email, u.avatar 
    FROM sessions s 
    JOIN users u ON s.user_id = u.id 
    WHERE s.session_token = ? AND s.expires_at > NOW()
");
$stmt->bind_param("s", $sessionToken);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(['success' => false, 'message' => 'Invalid or expired session']);
    $stmt->close();
    $conn->close();
    exit;
}

$session = $result->fetch_assoc();
$stmt->close();
$conn->close();

// Get avatar name
$avatarNames = [
    'owl' => '🦉 Wise Owl',
    'fox' => '🦊 Clever Fox',
    'rabbit' => '🐰 Happy Rabbit'
];

echo json_encode([
    'success' => true,
    'user' => [
        'id' => $session['user_id'],
        'username' => $session['username'],
        'email' => $session['email'],
        'avatar' => $session['avatar'],
        'avatarName' => $avatarNames[$session['avatar']]
    ]
]);
?>