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
  <link href="images/icons/favicon.pn g" rel="apple-touch-icon">

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
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

                <form class="form" action="email" method="post">
                  <input type="hidden" name="action" value="verifyOTP">

                  <span class="close">X</span>

                  <div class="info">
                    <span class="title">Password recovery</span>
                    <p class="description">Enter the verify code sent to your mail: ${useremail}</p>
                    <c:if test="${message != null}">
                      <p style="border: #1c1e28; text-align: center; color: #ea1717"><i>${message}</i></p>
                    </c:if>
                  </div>
                  <div class="input-fields">
                    <input placeholder="" type="tel" maxlength="1" name="opt01">
                    <input placeholder="" type="tel" maxlength="1" name="opt02">
                    <input placeholder="" type="tel" maxlength="1" name="opt03">
                    <input placeholder="" type="tel" maxlength="1" name="opt04">
                    <input placeholder="" type="tel" maxlength="1" name="opt05">
                    <input placeholder="" type="tel" maxlength="1" name="opt06">
                    <input type="hidden" name="email" value=${useremail}>
                  </div>

                  <div class="action-btns">
                    <button type="submit" id="verify">
                      <a class="verify" style="color: #FFFFFF;">Verify</a>
                    </button>
                      <a class="clear" onclick="clearFields()">Clear</a>
                  </div>
                </form>
                <script>
                  function clearFields() {
                    var inputFields = document.querySelectorAll('.input-fields input[type="tel"]');
                    inputFields.forEach(function (input) {
                      input.value = '';
                    });
                  }
                </script>
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