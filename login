<?php
    include 'conn.php';

    session_start();

    if($_SERVER['REQUEST_METHOD'] == "POST")
    {
        $name = $_POST['name'];
        $password= $_POST['password'];
        $remember = isset($_POST['remember']);

        $sql = "SELECT * FROM users WHERE username = '$name'";

        $result = mysqli_query($conn, $sql);

        if($result->num_rows>1)
        {
            $user = $result->fetch_assoc();

            if(password_verify($password, $user['password']))
            {
                $_SESSION['name'] = $name;
                if($remember)
                {
                    setcookie('username', $name. time() + 86400*7, "/");
                }
                header("Location: userhome.php");
            }
            else
            {
                echo 'invalid password';
            }
        }
        else
        {
            echo "user not found";
        }
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>login</h1>
    <form action="" method="post">
        username: <input type="text" name="name" id=""><br>
        password <input type="password" name="password" id=""><br>
        <input type="submit" name="submit" id="" value="login"><br>
        remember me <input type="checkbox" name="remember"><br>
    </form>
</body>
</html>
