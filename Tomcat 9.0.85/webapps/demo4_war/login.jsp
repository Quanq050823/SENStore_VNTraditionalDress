<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Login - COZASTORE</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="images/icons/favicon.png" rel="icon">
    <link href="images/icons/favicon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="vendor2/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor2/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="vendor2/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="vendor2/quill/quill.snow.css" rel="stylesheet">
    <link href="vendor2/quill/quill.bubble.css" rel="stylesheet">
    <link href="vendor2/remixicon/remixicon.css" rel="stylesheet">
    <link href="vendor2/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
<main>
    <div class="container">

        <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                        <div class="d-flex justify-content-center py-4">
                            <a href="Home.jsp" class="logo d-flex align-items-center w-auto">
                                <img src="images/icons/logo-01.png" alt="">
                                <span class="d-none d-lg-block">Member</span>
                            </a>
                        </div><!-- End Logo -->

                        <div class="card mb-3">

                            <div class="card-body">

                                <div class="pt-4 pb-2">
                                    <h5 class="card-title text-center pb-0 fs-4">Login to Your Account</h5>
                                    <p class="text-center small">Enter your username & password to login</p>
                                </div>
                                <form action="login" method="post">
                                    <form class="row g-3 needs-validation" novalidate>
                                        <input type="hidden" name="action" value="go">
                                        <div class="col-12">
                                            <label for="yourUsername" class="form-label">Username</label>
                                            <div class="input-group has-validation">
                                                <span class="input-group-text" id="inputGroupPrepend">@</span>
                                                <input type="text" name="username" class="form-control" id="yourUsername" required>
                                                <div class="invalid-feedback">Please enter your username.</div>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <label for="yourPassword" class="form-label">Password</label>
                                            <input type="password" name="password" class="form-control" id="yourPassword" required>
                                            <div class="invalid-feedback">Please enter your password!</div>
                                        </div>

                                        <div class="col-12">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="remember" id="rememberMe">
                                                <label class="form-check-label" for="rememberMe">Remember me</label>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <button class="btn btn-primary w-100" type="submit">Login</button>
                                        </div>

                                        <c:if test="${message != null}">
                                            <p style="border: #1c1e28; text-align: center; color: #ea1717"><i>${message}</i></p>
                                        </c:if>

                                        <div class="col-12">
                                            <p class="small mb-0">Don't have account? <a href="register.jsp">Create an account</a></p>
                                        </div>
                                        <div class="col-12">
                                            <p class="small mb-0">Forget password? <a href="forgetpass.jsp">Get help</a></p>
                                        </div>
                                    </form>
                                </form>
                            </div>
                        </div>

                        <div class="credits">
                            Contact us <a href="Home.jsp">Coza Store</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</main><!-- End #main -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="vendor2/apexcharts/apexcharts.min.js"></script>
<script src="vendor2/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="vendor2/chart.js/chart.umd.js"></script>
<script src="vendor2/echarts/echarts.min.js"></script>
<script src="vendor2/quill/quill.min.js"></script>
<script src="vendor2/simple-datatables/simple-datatables.js"></script>
<script src="vendor2/tinymce/tinymce.min.js"></script>
<script src="vendor2/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="js/login.js"></script>

</body>

</html>
