
<%@ page import="java.util.List" %>
<%@ page import="model.Cart" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.ProductEntity" %>
<%@ page import="model.CustomerEntity" %>
<%@ page import="Service.CartService" %>
<%@ page import="Service.impl.CartServiceImpl" %>
<%@ page import="Controller.Customer.CartController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.CookieUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Product</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="images/icons/favicon.png"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/linearicons-v1.0.0/icon-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/slick/slick.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/MagnificPopup/magnific-popup.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="css/util.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">

    <link href="vendor2/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="vendor2/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="vendor2/quill/quill.snow.css" rel="stylesheet">
    <link href="vendor2/quill/quill.bubble.css" rel="stylesheet">
    <link href="vendor2/remixicon/remixicon.css" rel="stylesheet">
    <link href="vendor2/simple-datatables/style.css" rel="stylesheet">
    <!--===============================================================================================-->
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!--===============================================================================================-->
    <script src="js/vietnamlocalselector.js"></script>
    <script src="js/citycombobox.js"></script>
    <!--===============================================================================================-->
</head>
<body class="animsition">
    <!-- Header -->
    <header class="header-v2">
        <!-- Header desktop -->
        <div class="container-menu-desktop trans-03">
            <div class="wrap-menu-desktop">
                <nav class="limiter-menu-desktop p-l-45">

                    <!-- Logo desktop -->
                    <a href="#" class="logo">
                        <img src="images/icons/logo-01.png" alt="IMG-LOGO">
                    </a>

                    <!-- Menu desktop -->
                    <div class="menu-desktop">
                        <ul class="main-menu">
                            <li class="active-menu">
                                <a href="Home.jsp">Home</a>
                            </li>

                            <li class="label1" data-label1="hot">
                                <a href="product?action=getShop">Shop</a>
                            <li>
                                <a href="cart?action=getCart">Cart</a>
                            </li>

                            <li>
                                <a href="about.jsp">About</a>
                            </li>

                            <%--							<li>--%>
                            <%--								<a href="contact.jsp">Contact</a>--%>
                            <%--							</li>--%>
                        </ul>
                    </div>

                    <!-- Icon header -->
                    <div class="wrap-icon-header flex-w flex-r-m h-full">

                        <div class="flex-c-m h-full p-l-18 p-r-25 bor5">
                            <%
                                int itemCount = 0;
                                List<CartItem> products = new ArrayList<>();
                                if (session.getAttribute("user")!=null ) {
                                    CartController.getCart(request,response);
                                    products = (List<CartItem>) session.getAttribute("cart");
                                    itemCount = products.size();
                                }
                            %>
                            <div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 icon-header-noti js-show-cart" data-notify="<%=itemCount%>">
                                <i class="zmdi zmdi-shopping-cart"></i>
                            </div>
                        </div>

                        <div class="flex-c-m h-full p-lr-19">
                            <%if (session.getAttribute("user")!=null){%>
                            <%CustomerEntity currCustomer = (CustomerEntity) session.getAttribute("user");%>

                            <li class="nav-item dropdown pe-3">

                                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                                    <img src="images/icons/avt.png" alt="Profile" class="rounded-circle">
                                    <span class="d-none d-md-block dropdown-toggle ps-2"><%=currCustomer.getCustomerFName() + " " + currCustomer.getCustomerLName()%></span>
                                </a><!-- End Profile Iamge Icon -->
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                                    <li class="dropdown-header">
                                        <h6><%=currCustomer.getCustomerFName() + " " + currCustomer.getCustomerLName()%></h6>
                                            <span class="useraccount">
                                                <%
                                                    Cookie[] cookies = request.getCookies();
                                                    String emailAddress = CookieUtil.getCookieValue(cookies, "emailCookie");

                                                    if (emailAddress != null && !emailAddress.equals("")) {
                                                %>
                                                    <%= emailAddress %>
                                                <%
                                                } else {
                                                %>
                                                    Welcome!
                                                <%
                                                    }
                                                %>
                                            </span>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="login?action=CheckUser">
                                            <i class="bi bi-person"></i>
                                            <span>My Account</span>
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="contact.jsp">
                                            <i class="bi bi-question-circle"></i>
                                            <span>Need Help?</span>
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="login?action=logout">
                                            <i class="bi bi-box-arrow-right"></i>
                                            <span>Sign Out</span>
                                        </a>
                                    </li>
                                </ul><!-- End Profile Dropdown Items -->
                            </li><!-- End Profile Nav -->
                            <%}
                            else {%>
                            <a class="nav-link nav-profile d-flex align-items-center pe-0" href="login?action=CheckUser">
                                <span class="d-none d-md-block ps-2">Log In</span>
                            </a>
                            <%}%>
                        </div>
                    </div>
                </nav>
            </div>
        </div>

        <!-- Header Mobile -->
        <div class="wrap-header-mobile">
            <!-- Logo moblie -->
            <div class="logo-mobile">
                <a href="Home.jsp"><img src="images/icons/logo-01.png" alt="IMG-LOGO"></a>
            </div>

            <!-- Icon header -->
            <div class="wrap-icon-header flex-w flex-r-m h-full m-r-15">
                <div class="flex-c-m h-full p-r-10">
                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 js-show-modal-search">
                        <i class="zmdi zmdi-search"></i>
                    </div>
                </div>

                <div class="flex-c-m h-full p-lr-10 bor5">
                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-lr-11 icon-header-noti js-show-cart" data-notify="2">
                        <i class="zmdi zmdi-shopping-cart"></i>
                    </div>
                </div>
            </div>

            <!-- Button show menu -->
            <div class="btn-show-menu-mobile hamburger hamburger--squeeze">
                    <span class="hamburger-box">
                        <span class="hamburger-inner"></span>
                    </span>
            </div>
        </div>


        <!-- Menu Mobile -->
        <div class="menu-mobile">
            <ul class="main-menu-m">
                <li>
                    <a href="Home.jsp">Home</a>
                    <!--					<ul class="sub-menu-m">-->
                    <!--						<li><a href="index.html">Homepage 1</a></li>-->
                    <!--						<li><a href="Home.jsp">Homepage 2</a></li>-->
                    <!--						<li><a href="home-03.html">Homepage 3</a></li>-->
                    <!--					</ul>-->
                    <span class="arrow-main-menu-m">
                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                        </span>
                </li>

                <li>
                    <a href="product.jsp" class="label1 rs1" data-label1="hot">Cart</a>
                </li>

                <li>
                    <a href="shoping-cart.jsp">Cart</a>
                </li>

                <li>
                    <a href="about.jsp">About</a>
                </li>

                <%--				<li>--%>
                <%--					<a href="contact.jsp">Contact</a>--%>
                <%--				</li>--%>
            </ul>
        </div>

        <!-- Modal Search -->
        <div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
            <div class="container-search-header">
                <button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
                    <img src="images/icons/icon-close2.png" alt="CLOSE">
                </button>

                <form class="wrap-search-header flex-w p-l-15">
                    <button class="flex-c-m trans-04">
                        <i class="zmdi zmdi-search"></i>
                    </button>
                    <input class="plh3" type="text" name="search" placeholder="Search...">
                </form>
            </div>
        </div>
    </header>
    <!-- Cart -->
    <div class="wrap-header-cart js-panel-cart">
        <div class="s-full js-hide-cart"></div>

        <div class="header-cart flex-col-l p-l-65 p-r-25">
            <div class="header-cart-title flex-w flex-sb-m p-b-8">
				<span class="mtext-103 cl2">
					Your Cart
				</span>

                <div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
                    <i class="zmdi zmdi-close"></i>
                </div>
            </div>

            <div class="header-cart-content flex-w js-pscroll">
                <ul class="header-cart-wrapitem w-full">
                    <%
                    float tmpSum = 0;
                    if (session.getAttribute("user")!=null){
                        for (CartItem cartItem : products){
                            ProductEntity product = cartItem.getProduct();
                    %>

                        <li class="header-cart-item flex-w flex-t m-b-12">
                            <div class="header-cart-item-img">
                                <img src="data:image/jpeg;base64,<%=product.getImages().get(0).getProductImage()%>" alt="IMG">
                            </div>

                            <div class="header-cart-item-txt p-t-8">
                                <a href="product?action=getDetails&productId=<%=product.getProductId()%>" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                                    <%=product.getProductName()%>
                                </a>

                                <%
                                tmpSum += product.getProductPrice()*cartItem.getCartItemQuantity();
                                %>

                                <span class="header-cart-item-info">
                                <%=cartItem.getCartItemQuantity()%> x $<%=product.getProductPrice()%>
                                    (<%=product.getSize().getSizeName()%> / <%=product.getColor().getColorName()%>)
                            </span>
                            </div>
                        </li>
                        <%}%>
                    <%}%>
                <div class="w-full">
                    <div class="header-cart-total w-full p-tb-40">
                        Total: $<%=tmpSum%>>
                    </div>

                    <div class="header-cart-buttons flex-w w-full">
                        <%--<a href="cart?" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
                            Check Out
                        </a>--%>

                        <a href="cart?" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
                            Check Out
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

