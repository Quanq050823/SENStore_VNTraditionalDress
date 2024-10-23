<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.CustomerEntity" %>
<%@ page import="java.util.List" %>
<%@ include file="../include/header.jsp" %>

<main id="main" class="main">

    <div class="pagetitle">
        <h1>Customer Management</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="productManage.jsp">Home</a></li>
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
                        <h5 class="card-title">Customer</h5>
                        <td><span class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#addcustomer">Add</span>
                            <div class="modal fade" id="addcustomer" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
                                <form action="customer" method="post" class="modal-dialog modal-lg " style="min-height: 100vh; width: 50%;">
                                    <div class="modal-content" style="background-color: #f0f0f0fa">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Add Customer</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form>
                                                <input type="hidden" name="action" value="addCustomers">
                                                <div class="mb-3">
                                                    <div class="row mb-3">
                                                        <label class="col-sm-2 col-form-label">Customer First Name</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" name="cusfname">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <div class="row mb-3">
                                                        <label class="col-sm-2 col-form-label">Customer Last Name</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" name="cuslname">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <div class="row mb-3">
                                                        <label class="col-sm-2 col-form-label">Phone number</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" name="cusphone">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <div class="row mb-3">
                                                        <label class="col-sm-2 col-form-label">Email</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" name="cusmail">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <div class="row mb-3">
                                                        <label class="col-sm-2 col-form-label">Address</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" name="cusaddress">
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#droporder">Saves Changes</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </td>

                        <table class="table table-borderless datatable">
                            <thead>
                            <tr>
                                <th scope="col">Customer id</th>
                                <th scope="col">Customer name</th>
                                <th scope="col">Phone number</th>
                                <th scope="col">Address</th>
                                <th scope="col">Edit</th>
                                <th scope="col">Ban</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                List<CustomerEntity> customerList = (List<CustomerEntity>) request.getAttribute("customerList");
                                if (request.getAttribute("customerList")!= null){%>

                            <% for (CustomerEntity customer : customerList) { %>
                            <%request.setAttribute("activated",customer.getActivated());%>
                            <tr>
                                <th scope="row"><p>#<%=customer.getCustomerId()%></p> </th>
                                <td><%=customer.getCustomerFName()%> <%=customer.getCustomerLName()%></td>
                                <td><a href="#" class="text-primary"><%=customer.getCustomerPhone()%></a></td>
                                <td><%=customer.getCustomerAddress()%></td>
                                <td><span class="btn badge bg-info" data-bs-toggle="modal" data-bs-target="#editcustomer<%=customer.getCustomerId()%>">Edit</span>
                                    <div class="modal fade" id="editcustomer<%=customer.getCustomerId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
                                        <form class="modal-dialog modal-lg" action="customer" method="post" style="min-height: 100vh; width: 50%;">
                                            <input type="hidden" name="action" value="editCustomers">
                                            <div class="modal-content" style="background-color: #f0f0f0fa">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Edit Customer</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <input type="hidden" name="cusid" value=<%=customer.getCustomerId()%>>

                                                <div class="modal-body">
                                                    <form>
                                                        <div class="mb-3">
                                                            <div class="row mb-3">
                                                                <label class="col-sm-2 col-form-label">Customer First Name</label>
                                                                <div class="col-sm-10">
                                                                    <input type="text" class="form-control" name="cusfname" value="<%=customer.getCustomerFName()%>">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <div class="row mb-3">
                                                                <label class="col-sm-2 col-form-label">Customer Last Name</label>
                                                                <div class="col-sm-10">
                                                                    <input type="text" class="form-control" name="cuslname" value="<%=customer.getCustomerFName()%>">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <div class="row mb-3">
                                                                <label class="col-sm-2 col-form-label">Phone number</label>
                                                                <div class="col-sm-10">
                                                                    <input type="text" class="form-control" name="cusphone" value="<%=customer.getCustomerPhone()%>">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <div class="row mb-3">
                                                                <label class="col-sm-2 col-form-label" style="color: #23c598; font-style: italic">Email</label>
                                                                <div class="col-sm-10">
                                                                    <input type="text" class="form-control" name="cusmail" value="<%=customer.getCustomerMail()%>">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <div class="row mb-3">
                                                                <label class="col-sm-2 col-form-label" style="color: #23c598; font-style: italic">Password</label>
                                                                <div class="col-sm-10">
                                                                    <input type="text" class="form-control" name="cuspwd" value="<%=customer.getCustomerPwd()%>">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <div class="row mb-3">
                                                                <label class="col-sm-2 col-form-label">Address</label>
                                                                <div class="col-sm-10">
                                                                    <input type="text" class="form-control" name="cusaddress" value="<%=customer.getCustomerAddress()%>">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#droporder">Saves Changes</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${activated eq '1'}">
                                            <span class="btn badge bg-danger" data-bs-toggle="modal" data-bs-target="#bancustomer<%=customer.getCustomerId()%>">Ban</span>
                                            <div class="modal fade" id="bancustomer<%=customer.getCustomerId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">BAN CUSTOMER</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure you want to Ban this customer? please check carefully before taking this action.
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <a href="customer?action=banCustomers&cusid=<%=customer.getCustomerId()%>">
                                                                <button type="submit" class="btn btn-danger" data-bs-dismiss="modal">Yes, Ban this customer</button>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:when test="${activated eq '0'}">
                                            <span class="btn badge bg-success" data-bs-toggle="modal" data-bs-target="#activecustomer<%=customer.getCustomerId()%>">Active</span>
                                            <div class="modal fade" id="activecustomer<%=customer.getCustomerId()%>" tabindex="-1" aria-hidden="true" style="display: none; position: fixed; top: 90px; left: 0; width: 100%; height: 80vh;">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">ACTIVE CUSTOMER</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure you want to Active this customer? please check carefully before taking this action.
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <a href="customer?action=activeCustomers&cusid=<%=customer.getCustomerId()%>">
                                                                <button type="submit" class="btn btn-success" data-bs-dismiss="modal">Yes, Active this customer</button>
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
