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

// Delete session
$stmt = $conn->prepare("DELETE FROM sessions WHERE session_token = ?");
$stmt->bind_param("s", $sessionToken);

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Logged out successfully']);
} else {
    echo json_encode(['success' => false, 'message' => 'Logout failed']);
}

$stmt->close();
$conn->close();
?>