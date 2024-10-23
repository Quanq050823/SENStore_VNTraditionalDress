<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="Controller.Customer.OrderController" %>
<%@ page import="Service.OrderDetailsService" %>
<%@ page import="Service.impl.OrderDetailServiceImpl" %>
<%@ page import="Service.ProductService" %>
<%@ page import="Service.impl.ProductServiceImpl" %>
<%@ page import="java.lang.String" %>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ include file="includes/header.jsp" %>

<!-- AccountInformation -->
<section class="sec-product bg0 p-t-100 p-b-50">
    <div class="container">
        <div id="parent" class="row">
            <div id="a" class="col-xs-12 col-sm-12 col-lg-9 col-left-account">
                <div class="title_head margin-bottom-20 m992">
                    <h1 class="title_center_page left">
                        <div id="padding__">Customer Account</div>
                    </h1>
                </div>
                <div class="form-signup name-account m992">
                    <%CustomerEntity currCustomer = (CustomerEntity) session.getAttribute("user");%>
                    <p><strong>Anhonn, <a href="#" style="color:#ad8610;"> <%=currCustomer.getCustomerFName() + " " + currCustomer.getCustomerLName()%> </a>&nbsp;!</strong></p>
                </div>
                <div class="col-xs-12 col-sm-12 col-lg-12 no-padding">
                    <div class="my-account">
                        <div class="dashboard">
                            <div class="recent-orders">
                                <div class="table-responsive tab-all" style="overflow-x:auto;">
                                    <table class="table table-cart" id="my-orders-table">
                                        <thead class="thead-default">
                                        <tr class="table_head">
                                            <th class="column-0">Order</th>
                                            <th class="column-1">Order Date</th>
                                            <th class="column-1.5">Complete Date</th>
                                            <th class="column-2">Order Price</th>
                                            <th class="column-3">Status</th>
                                            <th class="column-4"></th>
                                        </tr>
                                        </thead>

                                        <%
                                            OrderController.getOrders(request,response);

                                            List<OrderEntity> customerOrders = (List<OrderEntity>) session.getAttribute("customerOrders");
                                            if (session.getAttribute("customerOrders")!= null){%>

                                        <% for (OrderEntity order : customerOrders) { %>
                                        <tr class="table_row">
                                            <td class="column-0">
                                                <input type="hidden" name="requestedOrder" value="<%=order.getOrderId()%>">
                                                <button type="button" data-bs-toggle="modal" data-bs-target="#largeModal<%=order.getOrderId()%>" style="color: #9a6e3a" name="getOrderBtn" value="<%=order.getOrderId()%>">
                                                    <%=order.getOrderId()%>
                                                </button>

                                                <%--                                                    Edit Order in POPUP--%>
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
                                                                        <label style="font-weight: 700;color: #222;">
                                                                            <%=currCustomer.getCustomerFName() + currCustomer.getCustomerLName() + " - " + currCustomer.getCustomerPhone()%>
                                                                        </label>
                                                                        <label><%=order.getShippingAddress()%></label>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label style="font-weight: 700;color: #222;">Date: <%=order.getOrderDate()%> </label>
                                                                        <%String completeDate = "Not Completed";
                                                                            if (order.getOrderDeliveryDate() != null) completeDate = order.getOrderDeliveryDate().toString();
                                                                        %>
                                                                        <label style="font-weight: 700;color: #222;">Date: <%=completeDate%> </label>
                                                                        <div class="col-md-12 col-sm-12 col-xs-12 content-page customer-table-wrap detail-table-order">
                                                                            <div class="customer-table-bg">
                                                                                <p classs="title-detail">Order details	</p>
                                                                                <div class="table-responsive">
                                                                                    <table id="order_details" class="table tableOrder">
                                                                                        <tbody><tr height="40px">
                                                                                            <th class="">Product</th>
<%--                                                                                            <th class="text-center">Product id</th>--%>
                                                                                            <th class="text-center">Price</th>
                                                                                            <th class="text-center">Quantity</th>
                                                                                            <th class="total text-right">Total</th>
                                                                                        </tr>

                                                                                        <%
                                                                                            OrderDetailsService orderDetailsService = new OrderDetailServiceImpl();
                                                                                            ProductService productService = new ProductServiceImpl();
                                                                                            List<OrderDetail> orderProducts = orderDetailsService.findByOrderId(order.getOrderId());
                                                                                            float tmpProductPrice = 0;
                                                                                            for (OrderDetail orderProduct:orderProducts){

                                                                                                ProductEntity product = productService.findById(orderProduct.getProduct().getProductId());
                                                                                        %>

                                                                                        <tr height="40px" id="1196577302" class="odd">
                                                                                            <td class="" style="max-width:300px">
                                                                                                <a href="product?action=getDetails&productId=<%=product.getProductId()%>" title="">
                                                                                                    <img src="data:image/jpeg;base64,<%=product.getImages().get(0).getProductImage()%>" style="width: 100px" alt="IMG">
                                                                                                </a>
                                                                                                <br>
                                                                                                <%=product.getProductName()%>
                                                                                                <br>
                                                                                                <span class="variant_acc"><%="Size: " + product.getSize().getSizeName() + " / Color: " + product.getColor().getColorName() %></span>

                                                                                            </td>
                                                                                            <%--<td class="sku text-center">STDT003</td>--%>
                                                                                            <td class="money text-center"><%=product.getProductPrice()%></td>
                                                                                            <td class="quantity center text-center"><%=orderProduct.getOrderDetailQuantity()%></td>
                                                                                            <%tmpProductPrice += orderProduct.getOrderDetailQuantity() * product.getProductPrice(); %>
                                                                                            <td class="total money text-right"><%=orderProduct.getOrderDetailQuantity() * product.getProductPrice() %></td>
                                                                                        </tr>
                                                                                        <%}%>

                                                                                        <tr height="40px" class="order_summary">
                                                                                            <td class="text-right" colspan="4"><b>Product Cost</b></td>

                                                                                            <td class="total money text-right"><b><%=tmpProductPrice%></b></td>
                                                                                        </tr>

                                                                                        <tr height="40px" class="order_summary">
                                                                                            <td class="text-right" colspan="4"><b>Discount</b></td>
                                                                                            <td class="total money text-right"><b>0</b></td>
                                                                                        </tr>

                                                                                        <tr height="40px" class="order_summary">
                                                                                            <td class="text-right" colspan="4"><b>Shipping cost</b></td>
                                                                                            <td class="total money text-right"><b><%=order.getOrderShipping()%></b></td>
                                                                                        </tr>

                                                                                        <tr height="40px" class="order_summary order_total">
                                                                                            <td class="text-right" colspan="4"><b>Total Price</b></td>
                                                                                            <td class="total money text-right"><b><%=order.getOrderTotal()%></b></td>
                                                                                        </tr>
                                                                                        </tbody></table>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
<%--                                                                    <button type="button" class="btn btn-primary">Save Changes</button>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="column-1">
                                                <%=order.getOrderDate()%>
                                            </td>
                                            <td class="column-1.5">
                                                <%=completeDate%>
                                            </td>
                                            <td class="column-2"><%= order.getOrderTotal() %></td>
                                            <%
                                                String tmpStatus = "Not confirmed";
                                                if (order.getOrderStatus() != null) tmpStatus = order.getOrderStatus();
                                                request.setAttribute("tmpStatus", tmpStatus);
                                            %>
                                            <td class="column-3"> <%= tmpStatus %></td>

                                            <td class="column-4">
                                                <c:if test="${tmpStatus ne 'Cancel' and tmpStatus ne 'Complete'}">
                                                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#verticalycentered<%=order.getOrderId()%>">Cancel</button>
                                                </c:if>
                                                <div class="modal fade" id="verticalycentered<%=order.getOrderId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 150px; left: 0; width: 100%; height: 80vh;">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">CANCEL ORDER</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                Are you sure you want to cancel this order? please check carefully before taking this action.
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                <a href="order?action=cancel&orderId=<%=order.getOrderId()%>">
                                                                    <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Yes, Cancel this order</button>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% } %>
                                        <tbody>

                                        <c:if test="${isOutOfStock eq true}">
                                            <!-- JavaScript to trigger the click event when the page loads -->
                                            <button id="cancelButtonSpecial" type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#verticalycenteredSpecial" style="display: none;"></button>
                                            <script>
                                                window.onload = function() {
                                                    // Get the button element by its ID
                                                    var cancelButton = document.getElementById('cancelButtonSpecial');

                                                    // Simulate a click event on the button
                                                    cancelButton.click();
                                                };
                                            </script>

                                            <div class="modal fade" id="verticalycenteredSpecial" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 150px; left: 0; width: 100%; height: 80vh;">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">CREATING ORDER FAILED</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            ${outOfStockMessage}
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>

                                        <c:if test="${customerOrders == null}">
                                            <tr>
                                                <td colspan="6"><p style="color: #666666">There are no order.</p></td>
                                            </tr>
                                        </c:if>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="text-xs-right">
                                </div>
                            </div>
                            <div class="paginate-pages pull-right page-account">
                                <nav>
                                    <ul class="pagination clearfix">
                                        <li class="page-item disabled"><a class="page-link" href="#"><</a></li>
                                        <li class="page-item disabled"><a class="page-link" href="#">></a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="b" class="col-xs-12 col-sm-12 col-lg-3 col-right-account">
                <form class="block-account">
                    <div class="block-title-account"><h5 style="color: #323c3f; font-size: 20px">My Account</h5></div>
                    <div class="block-content form-signup">
                        <p>Account Name: <strong style="color:#ad8610; line-height: 20px;"> <%=currCustomer.getCustomerFName() + " " + currCustomer.getCustomerLName()%></strong></p>
                        <p><i class="fa fa-home font-some" aria-hidden="true"></i>  <span >Address: <%=currCustomer.getCustomerAddress()%></span></p>
                        <p><i class="fa fa-mobile font-some" aria-hidden="true"></i> <span>Phone numbers: <%=currCustomer.getCustomerPhone()%></span> </p>

<%--                        <p><i class="fa fa-map-marker font-some" aria-hidden="true"></i> <span> Level: <%=currAcc.getLevelId()%></span></p>--%>
<%--                        <p><i class="fa fa-yelp font-some" aria-hidden="true"></i> <span> Total Payment: <%=currAcc.getTotalPayment()%></span></p>--%>
                        <p style="margin-top:20px;"><a href="editcustomerin4.jsp" class="btn btn-bg full-width btn-lg btn-style article-readmore">Edit</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<%@ include file="includes/footer.jsp" %>
</body>
</html>
