<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Controller.ProductController" %>
<%@ page import="model.ProductEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="model.OrderEntity" %>
<%@ page import="Service.ProductService" %>
<%@ page import="Service.impl.ProductServiceImpl" %>
<%@ include file="../include/header.jsp" %>

<main id="main" class="main">

  <div class="pagetitle">
    <h1>Product Management</h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="cart">Home</a></li>
        <li class="breadcrumb-item active">Product Management</li>
      </ol>
    </nav>
  </div><!-- End Page Title -->

  <section class="section dashboard">
    <div class="row">
      <!-- Recent Order -->
      <div class="col-12">
        <div class="card recent-sales overflow-auto">
          <div class="card-body">
            <h5 class="card-title">Product</h5>
            <span class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#addproduct">Add</span>
            <div class="modal fade" id="addproduct" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
              <div class="modal-dialog modal-lg " style="min-height: 100vh; width: 50%;">
                <div class="modal-content" style="background-color: #f0f0f0fa">
                  <div class="modal-header">
                    <h5 class="modal-title">Add Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <form>
                      <input type="hidden" name="action" value="addProduct">
                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Existed product</label>
                          <div class="col-sm-10">
                            <select name="existedProduct" class="form-control" id="existedProduct">
                              <option value="none">New product</option>
                              <c:forEach var="product" items="${productDistinct}">
                                <option value="${product.productId}">${product.productName}</option>
                              </c:forEach>
                            </select>
                            <input type="hidden" id="selectedProductId" name="selectedProductId" value=""/>
                            <script>
                              document.getElementById('existedProduct').addEventListener('change', function() {

                                var selectedValue = this.value;
                                // Set lable to please insert Street
                                if (selectedValue === 'none') {
                                  document.getElementById('productName').value = '';
                                  document.getElementById('productPrice').value = '';
                                  document.getElementById('productInventory').value = '';
                                  document.getElementById('productStyle').value = '';

                                  document.getElementById('productCategory').value = '';
                                  document.getElementById('productSize').value = '';
                                  document.getElementById('productColor').value = '';
                                }
                                else {

                                }
                              });
                            </script>

                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Product name</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control" name="productName" id="productName" required="">
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Description</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control" name="productDescription" id="productDescription" required="">
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Price</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control" name="productPrice" id="productPrice" required="">
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Inventory</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control" name="productInventory" id="productInventory" required="">
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Style</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control" name="productStyle" id="productStyle" required="">
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Category</label>
                          <div class="col-sm-10">
                            <select name="productCategory" class="form-control" id="productCategory" required="">
                              <c:forEach var="category" items="${categoryList}">
                                <option value="${category.categoryId}">${category.categoryName}</option>
                              </c:forEach>
                            </select>
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Size</label>
                          <div class="col-sm-10">
                            <select name="productSize" class="form-control" id="productSize" required="">
                              <c:forEach var="size" items="${sizeList}">
                                <option value="${size.sizeId}">${size.sizeName}</option>
                              </c:forEach>
                            </select>
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Color</label>
                          <div class="col-sm-10">
                            <select name="productColor" class="form-control" id="productColor" required="">
                              <c:forEach var="color" items="${colorList}">
                                <option value="${color.colorId}">${color.colorName}</option>
                              </c:forEach>
                            </select>
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Product Image 1</label>
                          <div class="col-sm-10">
                            <input id="image1" name="ImageFile1" class="input-file" type="file" required="">
                          </div>
                        </div>
                      </div>

                      <div class="mb-3">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label">Product Image 2</label>
                          <div class="col-sm-10">
                            <input id="image2" name="ImageFile2" class="input-file" type="file" required="">
                          </div>
                        </div>
                      </div>

                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#droporder">Saves Changes</button>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>

            <table class="table table-borderless datatable">
              <thead>
              <tr>
                <th scope="col">Name</th>
                <th scope="col">Price</th>
                <th scope="col">Inventory</th>
                <th scope="col">Style</th>
                <th scope="col">Category</th>
                <th scope="col">Size</th>
                <th scope="col">Color</th>
<%--                <th scope="col">Preview</th>--%>
                <th scope="col">Edit</th>
                <th scope="col">Disable</th>
              </tr>
              </thead>
              <tbody>
              <%
                List<ProductEntity> productlist = (List<ProductEntity>) request.getAttribute("productList");
                if (request.getAttribute("productList")!= null){%>

              <% for (ProductEntity product : productlist) { %>
              <tr>
                <td><%=product.getProductName()%></td>
                <td><%=product.getProductPrice()%></td>
                <td><%=product.getProductInventory()%></td>
                <td><%=product.getProductStyle()%></td>
                <td><%=product.getCategory().getCategoryName()%></td>
                <td><%=product.getSize().getSizeName()%></td>
                <td><%=product.getColor().getColorName()%></td>
                <% request.setAttribute("imgsrc",product.getImages().get(0).getProductImage());%>

                  <td><a href="#"><img src="data:image/jpeg;base64,<%=product.getImages().get(0).getProductImage()%>" style="width: 50px;" alt="IMG"></a></td>

                <td><span class="btn badge bg-info" data-bs-toggle="modal" data-bs-target="#editproduct<%=product.getProductId()%>">Edit</span>
                  <div class="modal fade" id="editproduct<%=product.getProductId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
                    <div class="modal-dialog modal-lg " style="min-height: 100vh; width: 50%;">
                      <div class="modal-content" style="background-color: #f0f0f0fa">
                        <div class="modal-header">
                          <h5 class="modal-title">Edit Product</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                          <form action="product" method="post">
                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Product id</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" name="productId" value="<%=product.getProductId()%>">
                                </div>
                              </div>
                            </div>
                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Product name</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" name="productName" value="<%=product.getProductName()%>">
                                </div>
                              </div>
                            </div>
                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Price</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" name="productPrice" value="<%=product.getProductPrice()%>">
                                </div>
                              </div>
                            </div>
                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Inventory</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" name="productInventory" value="<%=product.getProductInventory()%>">
                                </div>
                              </div>
                            </div>
                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Style</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" name="productStyle" value="<%=product.getProductStyle()%>">
                                </div>
                              </div>
                            </div>
                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Category</label>
                                <div class="col-sm-10">

                                  <select name="productCategory" class="form-control" data-value="<%=product.getCategory().getCategoryName()%>">
                                    <option value="<%=product.getCategory().getCategoryId()%>">(Pre-selected: <%=product.getCategory().getCategoryName()%>)</option>
                                    <c:forEach var="category" items="${categoryList}">
                                      <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                  </select>
                                </div>
                              </div>
                            </div>

                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Size</label>
                                <div class="col-sm-10">
                                  <select name="productSize" class="form-control" data-value="<%=product.getCategory().getCategoryName()%>">
                                    <option value="<%=product.getSize().getSizeId()%>">(Pre-selected: <%=product.getSize().getSizeName()%>)</option>
                                    <c:forEach var="size" items="${sizeList}">
                                      <option value="${size.sizeId}">${size.sizeName}</option>
                                    </c:forEach>
                                  </select>
                                </div>
                              </div>
                            </div>

                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Color</label>
                                <div class="col-sm-10">
                                  <select name="productColor" class="form-control">
                                    <option value="<%=product.getColor().getColorId()%>">(Pre-selected: <%=product.getColor().getColorName()%>)</option>
                                    <c:forEach var="color" items="${colorList}">
                                      <option value="${color.colorId}">${color.colorName}</option>
                                    </c:forEach>
                                  </select>
                                </div>
                              </div>
                            </div>

                            <div class="mb-3">
                              <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Preview</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control">
                                </div>
                              </div>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                              <input type="hidden" name="action" value="editProduct">
                              <button type="submit" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#droporder">Saves Changes</button>
                            </div>
                          </form>
                        </div>

                      </div>
                    </div>
                  </div>
                </td>
                <td>
                  <%request.setAttribute("activated", product.isActivated());%>
                  <c:choose>
                    <c:when test="${activated eq true}">
                      <span class="btn badge bg-danger" data-bs-toggle="modal" data-bs-target="#bancustomer<%=product.getProductId()%>">Disable</span>
                      <div class="modal fade" id="bancustomer<%=product.getProductId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
                        <div class="modal-dialog modal-dialog-centered">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title">DISABLE PRODUCT</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                              Are you sure you want to disable this product? please check carefully before taking this action.
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                              <a href="product?action=disableProduct&productId=<%=product.getProductId()%>">
                                <button type="submit" class="btn btn-danger" data-bs-dismiss="modal">Yes, disable this product</button>
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </c:when>
                    <c:when test="${activated eq false}">
                      <span class="btn badge bg-success" data-bs-toggle="modal" data-bs-target="#activecustomer<%=product.getProductId()%>">Activate</span>
                      <div class="modal fade" id="activecustomer<%=product.getProductId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
                        <div class="modal-dialog modal-dialog-centered">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title">ACTIVATE PRODUCT</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                              Are you sure you want to activate this product? Please check carefully before taking this action.
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                              <a href="product?action=enableProduct&productId=<%=product.getProductId()%>">
                                <button type="submit" class="btn btn-success" data-bs-dismiss="modal">Yes, Active this product</button>
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </c:when>
                  </c:choose>
                </td>

              </tr>
              <% } %>
              <% } %>
              </tbody>
            </table>

          </div>

        </div>
      </div><!-- End Recent Order -->
    </div>
  </section>

</main><!-- End #main -->

<%@ include file="../include/footer.jsp" %>
