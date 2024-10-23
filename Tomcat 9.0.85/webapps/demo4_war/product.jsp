<%@ page import="model.*" %>
<%@ page import="Service.CategoryService" %>
<%@ page import="Service.impl.CategoryServiceImpl" %>
<%@ include file="includes/header.jsp" %>
<!-- Product -->
<div class="bg0 m-t-23 p-b-140">
	<div class="container">
		<div class="flex-w flex-sb-m p-b-52">
			<div class="flex-w flex-l-m filter-tope-group m-tb-10">
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*">
					All Products
				</button>

				<%CategoryService categoryService = new CategoryServiceImpl();
					List<model.CategoryEntity> categoryList = categoryService.findAllByActivated();
					request.setAttribute("categoryList",categoryList);
				%>

				<c:forEach var ="category" items="${categoryList}">
					<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".${category.categoryName}">
						${category.categoryName}
					</button>
				</c:forEach>
			</div>

			<div class="flex-w flex-c-m m-tb-10">
				<div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter">
					<i class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"></i>
					<i class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
					Filter
				</div>

				<div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
					<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
					<i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
					Search
				</div>
			</div>

			<!-- Search product -->
			<div class="dis-none panel-search w-full p-t-10 p-b-15">
				<form action="product" method="get" class="bor8 dis-flex p-l-15">
					<input type="hidden" name="action" value="searchByKeyword">
					<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
						<i class="zmdi zmdi-search"></i>
					</button>

					<input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" name="keyword" placeholder="Search">
				</form>
			</div>

			<!-- Filter -->
			<div class="dis-none panel-filter w-full p-t-10">
				<div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
					<div class="filter-col1 p-r-15 p-b-27">
						<div class="mtext-102 cl2 p-b-15">
							Sort By
						</div>
						<ul>
							<li class="p-b-6">
								<c:url var="lowToHighUrl" value="/product">
									<c:param name="action" value="filter" />
									<c:forEach var="productId" items="${productIds}">
										<c:param name="productIds" value="${productId}" />
									</c:forEach>
									<c:param name="flag" value="ASC" />
								</c:url>

								<c:choose>
									<c:when test="${param.flag eq 'ASC'}">
										<a href="${lowToHighUrl}" class="filter-link stext-106 trans-04 filter-link-active">
											Price: Low to High
										</a>
									</c:when>
									<c:otherwise>
										<a href="${lowToHighUrl}" class="filter-link stext-106 trans-04">
											Price: Low to High
										</a>
									</c:otherwise>
								</c:choose>
							</li>

							<li class="p-b-6">
								<c:url var="hightoLowUrl" value="/product">
									<c:param name="action" value="filter" />
									<c:forEach var="productId" items="${productIds}">
										<c:param name="productIds" value="${productId}" />
									</c:forEach>
									<c:param name="flag" value="DESC" />
								</c:url>
								<c:choose>
									<c:when test="${param.flag eq 'DESC'}">
									<a href="${hightoLowUrl}" class="filter-link stext-106 trans-04 filter-link-active">
										Price: High to Low
									</a>
									</c:when>
									<c:otherwise>
										<a href="${hightoLowUrl	}" class="filter-link stext-106 trans-04">
											Price: High to Low
										</a>
									</c:otherwise>
								</c:choose>
							</li>
						</ul>
					</div>

					<div class="filter-col2 p-r-15 p-b-27">
						<div class="mtext-102 cl2 p-b-15">
							Price
						</div>

						<ul>
							<li class="p-b-6">
								<c:set var="allProductsUrl" value="product?action=searchByPrice&start=0.0&end=99999.0" />
								<c:choose>
									<c:when test="${param.start eq '0.0' and param.end eq '99999.0'}">
										<a href="${allProductsUrl}" class="filter-link stext-106 trans-04 filter-link-active">
											All
										</a>
									</c:when>
									<c:otherwise>
										<a href="${allProductsUrl}" class="filter-link stext-106 trans-04">
											All
										</a>
									</c:otherwise>
								</c:choose>
							</li>

							<li class="p-b-6">
								<c:set var="Range50Url" value="product?action=searchByPrice&start=0.0&end=50.0" />
								<c:choose>
									<c:when test="${param.end eq '50.0'}">
										<a href="${Range50Url}" class="filter-link stext-106 trans-04 filter-link-active">
											$0.00 - $50.00
										</a>
									</c:when>
									<c:otherwise>
										<a href="${Range50Url}" class="filter-link stext-106 trans-04">
											$0.00 - $50.00
										</a>
									</c:otherwise>
								</c:choose>
							</li>
							<li class="p-b-6">
							<c:set var="Range100Url" value="product?action=searchByPrice&start=50.0&end=100.0" />
							<c:choose>
								<c:when test="${param.end eq '100.0'}">
									<a href="${Range100Url}" class="filter-link stext-106 trans-04 filter-link-active">
										$50.00 - $100.00
									</a>
								</c:when>
								<c:otherwise>
									<a href="${Range100Url}" class="filter-link stext-106 trans-04">
										$50.00 - $100.00
									</a>
								</c:otherwise>
							</c:choose>
							</li>

							<li class="p-b-6">
							<c:set var="Range150Url" value="product?action=searchByPrice&start=100.0&end=150.0" />
							<c:choose>
								<c:when test="${param.end eq '150.0'}">
									<a href="${Range150Url}" class="filter-link stext-106 trans-04 filter-link-active">
										$100.00 - $150.00
									</a>
								</c:when>
								<c:otherwise>
									<a href="${Range150Url}" class="filter-link stext-106 trans-04">
										$100.00 - $150.00
									</a>
								</c:otherwise>
							</c:choose>
							</li>

							<li class="p-b-6">
							<c:set var="Range200Url" value="product?action=searchByPrice&start=150.0&end=200.0" />
							<c:choose>
								<c:when test="${param.end eq '200.0'}">
									<a href="${Range200Url}" class="filter-link stext-106 trans-04 filter-link-active">
										$150.00 - $200.00
									</a>
								</c:when>
								<c:otherwise>
									<a href="${Range200Url}" class="filter-link stext-106 trans-04">
										$150.00 - $200.00
									</a>
								</c:otherwise>
							</c:choose>
							</li>

							<li class="p-b-6">
							<c:set var="Range200pUrl" value="product?action=searchByPrice&start=200.0&end=99999.0" />
							<c:choose>
								<c:when test="${param.start eq '200.0'}">
									<a href="${Range200pUrl}" class="filter-link stext-106 trans-04 filter-link-active">
										$200.00+
									</a>
								</c:when>
								<c:otherwise>
									<a href="${Range200pUrl}" class="filter-link stext-106 trans-04">
										$200.00+
									</a>
								</c:otherwise>
							</c:choose>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="row isotope-grid">
			<% List<ProductEntity> productList = (List<ProductEntity>) request.getAttribute("productList");
			if (productList != null){
			for (ProductEntity product :  productList) {
				request.setAttribute("product",product);
			%>
			<c:if test="${product.category.categoryName == 'Top'}">
				<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item Top">
					<!-- Block2 -->
					<div class="block2">
						<div class="block2-pic hov-img0">
							<img src="data:image/jpeg;base64,<%=product.getImages().get(0).getProductImage()%>" alt="IMG-PRODUCT">

							<a href="product?action=getDetails&productId=<%=product.getProductId()%>" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 <%--js-show-modal1--%>">
								Details
							</a>
						</div>

						<div class="block2-txt flex-w flex-t p-t-14">
							<div class="block2-txt-child1 flex-col-l">
								<a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
									<%=product.getProductName()%>
								</a>

								<span class="stext-105 cl3">
									$<%= product.getProductPrice() %>
								</span>
							</div>

							<div class="block2-txt-child2 flex-r p-t-3">
								<a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
									<img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
									<img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
								</a>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${product.category.categoryName =='Bottom'}">
				<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item Bottom">
					<!-- Block2 -->
					<div class="block2">
						<div class="block2-pic hov-img0">
							<img src="data:image/jpeg;base64,<%=product.getImages().get(0).getProductImage()%>" alt="IMG-PRODUCT">

							<a href="product?action=getDetails&productId=<%=product.getProductId()%>" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 <%--js-show-modal1--%>">
								Details
							</a>
						</div>

						<div class="block2-txt flex-w flex-t p-t-14">
							<div class="block2-txt-child1 flex-col-l">
								<a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
									<%=product.getProductName()%>
								</a>

								<span class="stext-105 cl3">
									$<%= product.getProductPrice() %>
								</span>
							</div>

							<div class="block2-txt-child2 flex-r p-t-3">
								<a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
									<img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
									<img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
								</a>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${product.category.categoryName =='Outwears'}">
				<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item Outwears">
					<!-- Block2 -->
					<div class="block2">
						<div class="block2-pic hov-img0">
							<img src="data:image/jpeg;base64,<%=product.getImages().get(0).getProductImage()%>" alt="IMG-PRODUCT">

							<a href="product?action=getDetails&productId=<%=product.getProductId()%>" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 <%--js-show-modal1--%>">
								Details
							</a>
						</div>

						<div class="block2-txt flex-w flex-t p-t-14">
							<div class="block2-txt-child1 flex-col-l">
								<a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
									<%=product.getProductName()%>
								</a>

								<span class="stext-105 cl3">
									$<%= product.getProductPrice() %>
								</span>
							</div>

							<div class="block2-txt-child2 flex-r p-t-3">
								<a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
									<img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
									<img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
								</a>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${product.category.categoryName=='Accessories'}">
				<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item Accessories">
					<!-- Block2 -->
					<div class="block2">
						<div class="block2-pic hov-img0">
							<img src="data:image/jpeg;base64,<%=product.getImages().get(0).getProductImage()%>" alt="IMG-PRODUCT">

							<a href="product?action=getDetails&productId=<%=product.getProductId()%>" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 <%--js-show-modal1--%>">
								Details
							</a>
						</div>

						<div class="block2-txt flex-w flex-t p-t-14">
							<div class="block2-txt-child1 flex-col-l">
								<a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
									<%=product.getProductName()%>
								</a>

								<span class="stext-105 cl3">
									$<%= product.getProductPrice() %>
								</span>
							</div>

							<div class="block2-txt-child2 flex-r p-t-3">
								<a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
									<img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
									<img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
								</a>
							</div>
						</div>
					</div>
				</div>
			</c:if>
				<% } %>
				<% } %>

		</div>

		<!-- Load more -->
		<div class="flex-c-m flex-w w-full p-t-45">
			<a href="#" class="flex-c-m stext-101 cl5 size-103 bg2 bor1 hov-btn1 p-lr-15 trans-04">
				Load More
			</a>
		</div>
	</div>
</div>

<!-- Footer -->
<%@ include file="includes/footer.jsp" %>
</body>
</html>
