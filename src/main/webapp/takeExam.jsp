<!DOCTYPE html>
<html>
<head>
    <title>Add Question</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
<h2>Add Question to Exam</h2>
<form action="/exams/add-question" method="post">
    <div class="mb-3">
        <label>Exam ID</label>
        <input type="text" name="examId" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Question</label>
        <input type="text" name="question" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Option 1</label>
        <input type="text" name="opt1" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Option 2</label>
        <input type="text" name="opt2" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Option 3</label>
        <input type="text" name="opt3" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Option 4</label>
        <input type="text" name="opt4" class="form-control" required>
    </div>
    <div class="mb-3">
        <label>Correct Option (0–3)</label>
        <input type="number" name="correct" class="form-control" min="0" max="3" required>
    </div>
    <button type="submit" class="btn btn-success">Add Question</button>
</form>
</body>
</html>
