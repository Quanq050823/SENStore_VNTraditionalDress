<%@ page import="java.util.List" %>
<%@ page import="model.OrderEntity" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Or" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="Service.impl.OrderDetailServiceImpl" %>
<%@ page import="Service.OrderDetailsService" %>
<%@ page import="model.ProductEntity" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

<main id="main" class="main">

    <div class="pagetitle">
        <h1>Order Management</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="orderManage.jsp">Home</a></li>
                <li class="breadcrumb-item active">Product Management</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
        <div class="row">
            <!-- Recent Order -->
            <div class="col-12">
                <div class="card recent-sales overflow-auto">

                    <div class="filter">
                        <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                            <li class="dropdown-header text-start">
                                <h6>Filter</h6>
                            </li>

                            <li><a class="dropdown-item" href="#">Today</a></li>
                            <li><a class="dropdown-item" href="#">This Month</a></li>
                            <li><a class="dropdown-item" href="#">This Year</a></li>
                        </ul>
                    </div>

                    <div class="card-body">
                        <h5 class="card-title">Recent Order</h5>
                        <table class="table table-borderless datatable">
                            <thead>
                            <tr>
                                <th scope="col">Order id</th>
                                <th scope="col">Customer email</th>
                                <th scope="col">Create date</th>
                                <th scope="col">Complete date</th>
                                <th scope="col">Total Price</th>
                                <th scope="col">Status</th>
                                <th scope="col">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%List<OrderEntity> orderList = (List<OrderEntity>) request.getAttribute("orderList");
                                for (OrderEntity order : orderList){
                                    float tmpPrice = 0;
                                    OrderDetailsService orderDetailService = new OrderDetailServiceImpl();
                                    List<OrderDetail> orderDetailList = orderDetailService.findByOrderId(order.getOrderId());
                            %>
                            <%--                            <c:forEach var="order" items="${orderList}">--%>
                            <tr>
                                <th scope="row"><p type="button" data-bs-toggle="modal" data-bs-target="#largeModal<%=order.getOrderId()%>"> #<%=order.getOrderId()%> </p>
                                    <div class="modal fade" id="largeModal<%=order.getOrderId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
                                        <div class="modal-dialog modal-lg " style="min-height: 100vh; width: 50%;">
                                            <div class="modal-content" style="background-color: #f0f0f0fa">
                                                <div class="letterhead"></div>
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Order Information</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <form>
                                                        <div class="mb-3">
                                                            <label style="font-size: larger"><box-icon type='solid' name='location-plus'></box-icon>Address:</label>
                                                            <label style="font-weight: 700;color: #222;"> <%=order.getCustomer().getCustomerFName() + " " + order.getCustomer().getCustomerLName()%> (<%=order.getCustomer().getCustomerMail()%>)
                                                            </label>
                                                            <label><%=order.getShippingAddress()%></label>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label style="font-weight: 700;color: #222;">Date: <%=order.getOrderDate()%></label>
                                                            <div class="col-md-12 col-sm-12 col-xs-12 content-page customer-table-wrap detail-table-order">
                                                                <div class="customer-table-bg">
                                                                    <p classs="title-detail" style="margin-top: 10px">Order details</p>
                                                                    <div class="table-responsive">
                                                                        <table id="order_details" class="table tableOrder">
                                                                            <tbody><tr height="40px">
                                                                                <th class="">Product</th>
                                                                                <th class="text-center">Product information</th>
                                                                                <th class="text-center">Price</th>
                                                                                <th class="text-center">Quantity</th>
                                                                                <th class="total text-right">Total</th>
                                                                            </tr>

                                                                            <%for (OrderDetail orderDetail : orderDetailList){
                                                                                ProductEntity productEntity = orderDetail.getProduct();
                                                                            %>
                                                                            <tr height="40px" id="1196577302" class="odd">
                                                                                <td class="" style="max-width:150px">
                                                                                    <img src="data:image/jpeg;base64,<%=productEntity.getImages().get(0).getProductImage()%>" alt="IMG" style="width: 150px">


                                                                                </td>
                                                                                <td class="sku text-center">
                                                                                    <a href="productDetail?id=2" title=""><%=productEntity.getProductName()%></a> <br>
                                                                                    <span class="variant_acc">SIZE <%=productEntity.getSize().getSizeName()%>/</span>
                                                                                    <span class="variant_acc">COLOR <%=productEntity.getColor().getColorName()%></span>
                                                                                </td>
                                                                                <td class="money text-center">$<%=productEntity.getProductPrice()%></td>
                                                                                <td class="quantity center text-center"><%=orderDetail.getOrderDetailQuantity()%></td>
                                                                                <td class="total money text-right">$<%=productEntity.getProductPrice()*orderDetail.getOrderDetailQuantity()%></td>
                                                                            </tr>

                                                                            <%
                                                                                    tmpPrice += orderDetail.getProduct().getProductPrice() * orderDetail.getOrderDetailQuantity();
                                                                                }
                                                                            %>

                                                                            <tr height="40px" class="order_summary">
                                                                                <td class="text-right" colspan="4"><b>Products cost</b></td>
                                                                                <td class="total money text-right"><b>$<%=tmpPrice%></b></td>
                                                                            </tr>

                                                                            <tr height="40px" class="order_summary">
                                                                                <td class="text-right" colspan="4"><b>Discount</b></td>
                                                                                <td class="total money text-right"><b>$<%=order.getOrderDiscount()%></b></td>
                                                                            </tr>

                                                                            <tr height="40px" class="order_summary">
                                                                                <td class="text-right" colspan="4"><b>Shipping</b></td>
                                                                                <td class="total money text-right"><b>$<%=order.getOrderShipping()%></b></td>
                                                                            </tr>

                                                                            <tr height="40px" class="order_summary order_total">
                                                                                <td class="text-right" colspan="4"><b>Total Price</b></td>
                                                                                <td class="total money text-right"><b>$<%=order.getOrderTotal()%></b></td>
                                                                            </tr>
                                                                            </tbody></table>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <%request.setAttribute("orderStatus",order.getOrderStatus());%>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <c:if test="${orderStatus eq 'Shipping' || orderStatus eq null}">
                                                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#droporder">Drop Order</button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal fade" id="droporder" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 150px; left: 0; width: 100%; height: 80vh;">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">CANCEL ORDER</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    Are you sure you want to Drop this order? please check carefully before taking this action.
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <a href="order?action=cancelOrder&orderId=<%=order.getOrderId()%>">
                                                        <button type="submit" class="btn btn-danger" data-bs-dismiss="modal">Yes, Drop this order</button>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </th>
                                <td scope="row"><%=order.getCustomer().getCustomerPhone()%></td>
                                <td><%=order.getOrderDate()%></td>
                                <%String completeDate = "Not completed";
                                    if (order.getOrderDeliveryDate() != null) completeDate = order.getOrderDeliveryDate().toString();
                                %>
                                <td><%=completeDate%></td>
                                <td>$<%=order.getOrderTotal()%></td>

                                <c:choose>
                                    <c:when test="${orderStatus eq 'Complete'}">
                                        <td><span class="badge border-info border-1 text-info">Completed</span></td>
                                        <td></td>
                                    </c:when>
                                    <c:when test="${orderStatus eq 'Shipping'}">
                                        <td><span class="badge border-warning border-1 text-warning">Shipping</span></td>
                                        <td><span type="button" class="badge bg-success" data-bs-toggle="modal" data-bs-target="#verticalycentered<%=order.getOrderId()%>">Complete</span>
                                            <div class="modal fade" id="verticalycentered<%=order.getOrderId()%>"  tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 150px; left: 0; width: 100%; height: 80vh;">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">COMPLETE ORDER</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure you want to complete this order? please check carefully before taking this action.
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <a href="order?action=completeOrder&orderId=<%=order.getOrderId()%>">
                                                                <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">Yes, Complete this order</button>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </c:when>
                                    <c:when test="${orderStatus eq 'Cancel'}">
                                        <td><span class="badge border-danger border-1 text-danger">Canceled</span></td>
                                        <td></td>
                                    </c:when>
                                    <c:when test="${orderStatus eq null}">
                                        <td><span class="badge border-warning border-1 text-warning">Not confirmed</span></td>
                                        <td><span type="button" class="badge bg-info text-dark" data-bs-toggle="modal" data-bs-target="#verticalycentered2<%=order.getOrderId()%>">Accept</span>
                                            <div class="modal fade" id="verticalycentered2<%=order.getOrderId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 150px; left: 0; width: 100%; height: 80vh;">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">ACCEPT ORDER</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure you want to Accept this order? Please check carefully before taking this action.
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <a href="order?action=confirmOrder&orderId=<%=order.getOrderId()%>">
                                                                <button type="button" class="btn btn-outline-info" data-bs-dismiss="modal">
                                                                    Yes, Accept this order
                                                                </button>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </c:when>
                                </c:choose>

                            </tr>
                            <%--                            </c:forEach>--%>
                            <%}%>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div><!-- End Recent Order -->
        </div>
        </div><!-- End Left side columns -->
        </div>
    </section>

</main><!-- End #main -->
<%@ include file="../include/footer.jsp" %>

