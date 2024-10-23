<%@ include file="includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<section class="address margin-top-20">
    <div class="container page_address">
        <div class="row">
            <div class="col-xs-12 col-lg-12 adr_title">
                <h1 class="title-head">Edit Account Information  <a class="f-right back_account" href="login?action=CheckUser" alt=""><i class="fa fa-arrow-left" aria-hidden="true"></i>&nbsp;Back to account pages</a></h1>
            </div>
            <div class="col-sm-12 col-lg-12 col-address">
                <c:if test="${message != null}">
                    <p style="border: #1c1e28; text-align: center; color: #ea1717"><i>${message}</i></p>
                </c:if>
                <div class="row">
                    <div id="add_address" class="col-md-12 form-list" style="margin-top: 30px;">
                        <form accept-charset="UTF-8" action="account" method="post">
                            <div class="clearfix row">
                                <input type="hidden" name="action" value="edit">
                                <%CustomerEntity currCustomer = (CustomerEntity) session.getAttribute("user");%>
                                <div class="col-xs-12 col-lg-12">
                                    <fieldset class="form-group">
                                        <label style="font-weight: bold;">First Name<span>*</span></label>
                                        <input type="text" class="form-control req" required requiredmsg="Please fill this information!" name="fname" placeholder="Input your first name" value=<%=currCustomer.getCustomerFName()%>>
                                    </fieldset>
                                </div>
                                <div class="col-xs-12 col-lg-12">
                                    <fieldset class="form-group">
                                        <label style="font-weight: bold;">Last Name<span>*</span></label>
                                        <input type="text" class="form-control req" required requiredmsg="Please fill this information!" name="lname" placeholder="Input your last name" value=<%=currCustomer.getCustomerLName()%>>
                                    </fieldset>
                                </div>
                                <div class="col-xs-12 col-lg-12">
                                    <fieldset class="form-group">
                                        <label style="font-weight: bold;">Province<span>*</span></label>
                                        <select class="field-input" id="ls_province" name="customer_shipping_province">
                                        </select>
                                        <input type="hidden" id="input_ls_province" name="province" value="">
                                    </fieldset>
                                </div>
                                <div class="col-xs-12 col-lg-12">
                                    <fieldset class="form-group">
                                        <label style="font-weight: bold;">District<span>*</span></label>
                                        <select class="field-input" id="ls_district" name="customer_shipping_district">
                                        </select>
                                        <input type="hidden" id="input_ls_district" name="district" value="">
                                    </fieldset>
                                </div>
                                <div class="col-xs-12 col-lg-12">
                                    <fieldset class="form-group">
                                        <label style="font-weight: bold;">Ward<span>*</span></label>
                                        <select class="field-input" id="ls_ward" name="customer_shipping_ward">
                                        </select>
                                        <input type="hidden" id="input_ls_ward" name="ward" value="">
                                    </fieldset>
                                </div>
                                <div class="col-xs-12 col-lg-12">
                                    <fieldset class="form-group">
                                        <label style="font-weight: bold;">Street<span>*</span></label>
                                        <input type="text" class="form-control req " name="street" placeholder="Input your home address number" value="">
                                    </fieldset>
                                </div>
                                <div class="col-xs-12 col-lg-12">
                                    <fieldset class="form-group">
                                        <label style="font-weight: bold;">Phone number<span>*</span></label>
                                        <input type="number" class="form-control req " name="phonenumber" placeholder="Input your phone number" value="">
                                    </fieldset>
                                </div>
                                <div class="form-group clearfix col-xs-12">
                                    <div class="col-sm-12" style="margin: 0px 15px;">
                                        <div class="row">
                                            <button class="btn-bg-addresss btn btn-lg btn-primary" type="submit" id="click_accept" onclick="setInputValue()"><span>Save</span></button>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    function setInputValue() {
                                        var selectedprovince = $("#ls_province").find(":selected").text();
                                        $("#input_ls_province").val(selectedprovince);

                                        var selecteddistrict = $("#ls_district").find(":selected").text();
                                        $("#input_ls_district").val(selecteddistrict);

                                        var selectedward = $("#ls_ward").find(":selected").text();
                                        $("#input_ls_ward").val(selectedward);
                                    }
                                </script>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-sm-12 col-lg-12">
                <div class="row total_address">

                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="includes/footer.jsp"></jsp:include>
</body>
</html>