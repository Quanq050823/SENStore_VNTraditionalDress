<%@ page import="java.util.List" %>
<%@ page import="javax.persistence.EntityManager" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.Cart" %>
<%@ page import="model.ProductEntity" %>
<%@ page import="JpaConfig.JpaConfig" %>
<%@ page import="model.SizeEntity" %>
<%@ include file="includes/header.jsp" %>
<!-- breadcrumb -->
<div class="container">
	<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
		<a href="home-02.html.html" class="stext-109 cl8 hov-cl1 trans-04">
			Home
			<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
		</a>

		<span class="stext-109 cl4">
				Shoping Cart
			</span>
	</div>
</div>
<!-- Shoping Cart -->
<form class="bg0 p-t-75 p-b-85" action = "order" method="post" id="myForm">
	<div class="container">
		<div class="row">
			<div class="col-lg-10 col-xl-7 m-lr-auto m-b-50">
				<div class="m-l-25 m-r--38 m-lr-0-xl">

					<div class="table-responsive tab-all" style="overflow-x:auto;">
						<table class="table table-cart" id="my-orders-table">
							<thead class="thead-default">
							<tr class="table_head">
								<th class="column-0">Checks</th>
								<th class="column-1">Product</th>
								<th class="column-2">Type</th>
								<th class="column-3">Price</th>
								<th class="column-4">Quantity</th>
								<th class="column-5">Total</th>
							</tr>
							</thead>

							<% List<CartItem> customerCart = (List<CartItem>) session.getAttribute("cart");
								if (customerCart != null){
									for (CartItem cartItem : customerCart) {
										ProductEntity product = cartItem.getProduct();
							%>
							<tr class="table_row">
								<td class="column-0" style="">
									<input class="ui-checkbox" type = "checkbox" name="checkedProduct" value="<%=cartItem.getCartItemId()%>">
								</td>
								<script>
									document.getElementById("myForm").onsubmit = function() {
										var checkboxes = document.querySelectorAll('input[type="checkbox"]');
										var isChecked = false;

										for (var i = 0; i < checkboxes.length; i++) {
											if (checkboxes[i].checked) {
												isChecked = true;
												break;
											}
										}

										if (!isChecked) {
											alert("Please select at least one product.");
											return false; // Prevent form submission
										}
									};
								</script>

								<td class="column-1">
									<a href="cart?action=removeCart&cartItemId=<%=cartItem.getCartItemId()%>">
										<div class="how-itemcart1" >
											<img src="data:image/jpeg;base64,<%=product.getImages().get(0).getProductImage()%>" alt="IMG">
										</div>
									</a>
								</td>

								<td class="column-2">
									<a href="product?action=getDetails&productId=<%=product.getProductId()%>" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
										<%= product.getProductName()%> <br>
									</a>
									Size
									<%=product.getSize().getSizeName() + " / Color " + product.getColor().getColorName() %>
								</td>

								<td class="column-3">$ <%= product.getProductPrice() %></td>
								<% int currentQuantity = cartItem.getCartItemQuantity();%>
								<td class="column-4" style="align-content: center">
									<div class="wrap-num-product flex-w m-l-auto m-r-0">
										<a class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m"
										   href="cart?action=addCart&productName=<%=product.getProductName()%>&size=<%=product.getSize().getSizeId()%>&color=<%=product.getColor().getColorId()%>&quantity=-1">
											<i class="fs-16 zmdi zmdi-minus"></i>
										</a>

										<input class="mtext-104 cl3 txt-center num-product" type="number" name="quantity" value="<%= currentQuantity %>">

										<a class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m"
										   href="cart?action=addCart&productName=<%=product.getProductName()%>&size=<%=product.getSize().getSizeId()%>&color=<%=product.getColor().getColorId()%>&quantity=1">
											<i class="fs-16 zmdi zmdi-plus"></i>
										</a>
									</div>
								</td>

								<c:if test="${notEnough eq true}">
									<button id="addedButtonFail" type="button" class="js-addcart-detail-fail" style="display: none;"></button>
									<script>
										window.onload = function() {
											// Get the button element by its ID
											var cancelButton = document.getElementById('addedButtonFail');
											// Simulate a click event on the button
											cancelButton.click();
										};
									</script>
								</c:if>

								<td class="column-5">$ <%= cartItem.getCartItemUnitPrice() %></td>
							</tr>
							<% } %>
							<% } %>

						</table>
					</div>

					<div class="flex-w flex-sb-m bor15 p-t-18 p-b-15 p-lr-40 p-lr-15-sm">
						<div class="flex-w flex-m m-r-20 m-tb-5">
							<input class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5" type="text" name="coupon" placeholder="Coupon Code">
						</div>

						<input type="hidden" name="action" value="checkOrder">
						<button type="submit" value="Submit">
							<div class="flex-c-m stext-101 cl2 size-119 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-10">
								Proceed Order
							</div>
						</button>
					</div>
				</div>
			</div>

		</div>
	</div>
</form>

<!-- Footer -->
<%@ include file="includes/footer.jsp" %>
</body>
</html>