<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Register - COZASTORE</title>
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
                  <span class="d-none d-lg-block">Be Member</span>
                </a>
              </div><!-- End Logo -->

              <form action="login" method="post">
                <div class="card mb-3">
                  <div class="card-body">

                    <div class="pt-4 pb-2">
                      <h5 class="card-title text-center pb-0 fs-4">Create an Account</h5>
                      <p class="text-center small">Enter your personal details to create account</p>
                    </div>

                    <form class="card-body" novalidate>
                      <input type="hidden" name="action" value="regist" >
                      <div class="input-col-md-5">
                        <div class="col-md-6">
                          <label for="firstname" class="form-label">First Name</label>
                          <input type="text" name="fname" class="form-control" id="firstname" required>
                          <div class="invalid-feedback">Please, enter your name!</div>
                        </div>

                        <div class="col-md-6">
                          <label for="lastname" class="form-label">Last Name</label>
                          <input type="text" name="lname" class="form-control" id="lastname" required>
                          <div class="invalid-feedback">Please, enter your name!</div>
                        </div>
                      </div>

                      <div class="col-12">
                        <label for="yourEmail" class="form-label">Your Email</label>
                        <div class="input-group has-validation">
                          <span class="input-group-text" id="inputGroupPrepend">@</span>
                          <input type="email" name="email" class="form-control" id="yourEmail" required>
                          <div class="invalid-feedback">Please enter a valid Email adddress!</div>
                        </div>
                      </div>

                      <div class="col-12">
                        <label for="Password" class="form-label">Your Password</label>
                        <input type="password" name="password" class="form-control" id="Password" required>
                        <div class="invalid-feedback">Please enter your password!</div>
                      </div>


                      <div class="col-12">
                        <label for="RePassword" class="form-label">Re-enter Password</label>
                        <input type="password" name="RePassword" class="form-control" id="RePassword" required>
                        <div class="invalid-feedback">Please re-check your password!</div>
                      </div>

                      <div class="col-12">
                        <div class="form-check">
                          <input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms" required>
                          <label class="form-check-label" for="acceptTerms">I agree and accept the <a href="#">terms and conditions</a></label>
                          <div class="invalid-feedback">You must agree before submitting.</div>
                        </div>
                      </div>
                      <div class="col-12">
                        <button class="btn btn-primary w-100" type="submit">Create Account</button>
                      </div>
                      <div class="col-12">
                        <p class="small mb-0">Already have an account? <a href="login.jsp">Log in</a></p>
                      </div>
                    </form>

                  </div>
                </div>
              </form>
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