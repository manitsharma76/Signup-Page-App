<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = new mysqli("localhost", "root", "", "flutterdb");

if ($conn->connect_error) {
    echo json_encode(["message" => "Connection failed"]);
    exit();
}

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$dob = $_POST['dob'];
$gender = $_POST['gender'];

$stmt = $conn->prepare("INSERT INTO submissions (name, email, phone, dob, gender) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sssss", $name, $email, $phone, $dob, $gender);

if ($stmt->execute()) {
    echo json_encode(["message" => "Form submitted successfully!"]);
} else {
    echo json_encode(["message" => "Submission failed."]);
}
