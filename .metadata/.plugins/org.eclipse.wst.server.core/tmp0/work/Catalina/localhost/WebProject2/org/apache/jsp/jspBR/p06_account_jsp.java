/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.60
 * Generated at: 2022-07-26 01:05:52 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jspBR;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.cy.dao.*;
import com.cy.dto.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public final class p06_account_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/jspBR/headerBR.jspf", Long.valueOf(1658395401000L));
    _jspx_dependants.put("/jspBR/bottom-service-centerBR.jspf", Long.valueOf(1657692720000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("com.cy.dto");
    _jspx_imports_packages.add("com.cy.dao");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.sql.Connection");
    _jspx_imports_classes.add("java.sql.ResultSet");
    _jspx_imports_classes.add("java.sql.PreparedStatement");
    _jspx_imports_classes.add("java.sql.DriverManager");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("    \r\n");
      out.write("    \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"css/p06.account.css\">\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>이메일 변경</title>\r\n");

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.1.12:1521:xe";
	String dbId = "oraclePort";
	String dbPw = "1234";
	int memberId = (int)(session.getAttribute("member_id"));
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url,dbId,dbPw);
	
	String sql = "select email_address from member where member_id = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,memberId);
	ResultSet rs = pstmt.executeQuery();
	
	String emailAddress = null;
	if(rs.next()) {
		emailAddress = rs.getString("email_address");
	}

	

      out.write("\r\n");
      out.write("<script src=\"../js/jquery-3.6.0.min.js\"></script>\r\n");
      out.write("<script src=\"../js/common_headerBR.js\"></script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\t");
      out.write("\r\n");
      out.write("<!-- 해더 html -->\t\r\n");
      out.write("<script>\r\n");
      out.write("\t/* $(function(){\r\n");
      out.write("\t\t$(\".svg-nfLogo logo\").click(function(){\r\n");
      out.write("\t\t\tlocation.href =\"netflix.jsp\";\r\n");
      out.write("\t\t});\r\n");
      out.write("\t}); */\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<div id=\"hdSpace\">\r\n");
      out.write("\t\t<div id=\"hdPinTarget\" class=\"member-header\"\r\n");
      out.write("\t\t\tdata-uia=\"netflix-member-header\">\r\n");
      out.write("\t\t\t<div id=\"hd\">\r\n");
      out.write("\t\t\t\t<div id=\"headerBlind\"></div>\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t<a href=\"../index.jsp?profile_id=");
      out.print(Integer.parseInt(request.getParameter("profile_id")) );
      out.write("\" class=\"svg-nfLogo logo\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"netflix-header-svg-logo\">\r\n");
      out.write("\t\t\t\t\t\t<svg viewBox=\"0 0 111 30\"class=\"svg-icon svg-icon-netflix-logo\" aria-hidden=\"true\"focusable=\"false\">\r\n");
      out.write("                    <g id=\"netflix-logo\">\r\n");
      out.write("                        <path\r\n");
      out.write("\t\t\t\t\t\t\t\td=\"M105.06233,14.2806261 L110.999156,30 C109.249227,29.7497422 107.500234,29.4366857 105.718437,29.1554972 L102.374168,20.4686475 L98.9371075,28.4375293 C97.2499766,28.1563408 95.5928391,28.061674 93.9057081,27.8432843 L99.9372012,14.0931671 L94.4680851,-5.68434189e-14 L99.5313525,-5.68434189e-14 L102.593495,7.87421502 L105.874965,-5.68434189e-14 L110.999156,-5.68434189e-14 L105.06233,14.2806261 Z M90.4686475,-5.68434189e-14 L85.8749649,-5.68434189e-14 L85.8749649,27.2499766 C87.3746368,27.3437061 88.9371075,27.4055675 90.4686475,27.5930265 L90.4686475,-5.68434189e-14 Z M81.9055207,26.93692 C77.7186241,26.6557316 73.5307901,26.4064111 69.250164,26.3117443 L69.250164,-5.68434189e-14 L73.9366389,-5.68434189e-14 L73.9366389,21.8745899 C76.6248008,21.9373887 79.3120255,22.1557784 81.9055207,22.2804387 L81.9055207,26.93692 Z M64.2496954,10.6561065 L64.2496954,15.3435186 L57.8442216,15.3435186 L57.8442216,25.9996251 L53.2186709,25.9996251 L53.2186709,-5.68434189e-14 L66.3436123,-5.68434189e-14 L66.3436123,4.68741213 L57.8442216,4.68741213 L57.8442216,10.6561065 L64.2496954,10.6561065 Z M45.3435186,4.68741213 L45.3435186,26.2498828 C43.7810479,26.2498828 42.1876465,26.2498828 40.6561065,26.3117443 L40.6561065,4.68741213 L35.8121661,4.68741213 L35.8121661,-5.68434189e-14 L50.2183897,-5.68434189e-14 L50.2183897,4.68741213 L45.3435186,4.68741213 Z M30.749836,15.5928391 C28.687787,15.5928391 26.2498828,15.5928391 24.4999531,15.6875059 L24.4999531,22.6562939 C27.2499766,22.4678976 30,22.2495079 32.7809542,22.1557784 L32.7809542,26.6557316 L19.812541,27.6876933 L19.812541,-5.68434189e-14 L32.7809542,-5.68434189e-14 L32.7809542,4.68741213 L24.4999531,4.68741213 L24.4999531,10.9991564 C26.3126816,10.9991564 29.0936358,10.9054269 30.749836,10.9054269 L30.749836,15.5928391 Z M4.78114163,12.9684132 L4.78114163,29.3429562 C3.09401069,29.5313525 1.59340144,29.7497422 0,30 L0,-5.68434189e-14 L4.4690224,-5.68434189e-14 L10.562377,17.0315868 L10.562377,-5.68434189e-14 L15.2497891,-5.68434189e-14 L15.2497891,28.061674 C13.5935889,28.3437998 11.906458,28.4375293 10.1246602,28.6868498 L4.78114163,12.9684132 Z\"\r\n");
      out.write("\t\t\t\t\t\t\t\tid=\"Fill-14\"></path>\r\n");
      out.write("                    </g>\r\n");
      out.write("                </svg><span class=\"screen-reader-text\"></span>\r\n");
      out.write("                </a>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<!-- <div class=\"account-secondary-navigation last\">\r\n");
      out.write("\t\t\t\t\t<div class=\"tagline priceMessage\"></div>\r\n");
      out.write("\t\t\t\t\t<div id=\"account-tools\" data-uia=\"netflix-member-header-profile-selector\">\r\n");
      out.write("\t\t\t\t\t\t<div id=\"profileSelector\" class=\"profile-selector\" tabindex=\"0\" role=\"button\">\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"current-profile\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<img class=\"avatar\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\tsrc=\"https://occ-0-3076-993.1.nflxso.net/dnm/api/v6/K6hjPJd6cR6FpVELC5Pd6ovHRSk/AAAABacp_EfyoslSenK44Ni265oL1YUe7QBW140sxeVKQZnKdSz-yTrU0LhREEuVpDjXsCRTkaiaOq60qOBo42B9KRGQMNuO5GE.png?r=869\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\talt=\"\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<span class=\"profile-arrow\"></span>\r\n");
      out.write("\t\t\t\t\t\t\t\t<span class=\"trigger\"></span>\r\n");
      out.write("\t\t\t\t\t\t\t\t<img class=\"img_arrow\" src=\"../img/upper_arrow_grey.png\"/>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t<div class=\"profiles-container\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<div class=\"profile-selector\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<ul class=\"profiles structural\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<li class=\"profile\"><a\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\thref=\"/SwitchProfile?tkn=6IMTSN53VFHMDG5RDSAMROD76Y\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\trole=\"button\"> <img\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\tsrc=\"https://occ-0-3076-993.1.nflxso.net/dnm/api/v6/K6hjPJd6cR6FpVELC5Pd6ovHRSk/AAAABXeeIVtmgzU089rwEnRNnxk6Q1GHEkPghoK2PHnziJv4WrrO_QxZ4crVPJIe3wjusYZjCmN1sxolKdCbQ1jli_HtH2hAzsU.png?r=fcd\"\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\talt=\"\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<div id=\"\" class=\"name\" data-uia=\"\">크롱</div>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t\t\t<ul class=\"profile-manage structural\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<li class=\"manage\"><a\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\thref=\"http://localhost:9090/Webproject2/jsp/p01.account.jsp\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t프로필 관리</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t\t\t\t\t<ul id=\"accountLinks\" class=\"links structural\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<li class=\"\"><a\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\thref=\"http://localhost:9090/Webproject2/jsp/p05.account.jsp\">계정</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<li class=\"\"><a href=\"\">고객 센터</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<li class=\"\" data-uia=\"profiles-sign-out-link\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t<a href=\"\">넷플릭스에서 로그아웃</a></li>\r\n");
      out.write("\t\t\t\t\t\t\t\t</ul>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div> -->\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("<!-- 해더 html -->\r\n");
      out.write("\r\n");
      out.write("\t<div class=\"center\">\r\n");
      out.write("\t\t<!---->\r\n");
      out.write("\t\t<svg viewBox=\"0 0 64 76\" class=\"icon-shield\">\r\n");
      out.write("                <g fill=\"none\" fill-rule=\"nonzero\">\r\n");
      out.write("                    <path fill=\"#B3B3B3\"\r\n");
      out.write("\t\t\t\td=\"M63.807 19.543c-.077-2.016-.077-3.955-.077-5.816a2.612 2.612 0 00-2.631-2.637C49.722 11.012 41.055 7.755 33.857.776c-1.006-1.009-2.708-1.009-3.714 0-7.198 6.98-15.865 10.236-27.164 10.236A2.612 2.612 0 00.347 13.65c0 1.861 0 3.8-.077 5.894-.387 19.155-.929 45.29 30.879 56.302.31.077.541.155.851.155.31 0 .62-.078.851-.155C64.66 64.833 64.117 38.698 63.807 19.543zM32 70.493C4.759 60.568 5.146 38.854 5.533 19.699c0-1.163.077-2.249.077-3.335C16.212 15.82 24.725 12.641 32 6.282c7.275 6.359 15.788 9.616 26.39 10.004 0 1.085 0 2.171.077 3.334.387 19.233.774 40.947-26.467 50.874z\">\r\n");
      out.write("                    </path>\r\n");
      out.write("                    <path fill=\"#E50914\"\r\n");
      out.write("\t\t\t\td=\"M41.132 28.771l-12.77 12.796-5.494-5.506c-1.006-1.008-2.709-1.008-3.792 0-1.006 1.008-1.006 2.715 0 3.8l7.352 7.368c.542.542 1.16.775 1.857.775.697 0 1.393-.233 1.858-.775l14.704-14.735c1.006-1.008 1.006-2.714 0-3.8a2.59 2.59 0 00-3.715.077z\">\r\n");
      out.write("                    </path>\r\n");
      out.write("                </g>\r\n");
      out.write("            </svg>\r\n");
      out.write("\t\t<h1 class=\"action-headline\" data-uia=\"action-headline\">\r\n");
      out.write("\t\t\t<span id=\"\" data-uia=\"\">먼저 본인 확인을 해볼까요?</span>\r\n");
      out.write("\t\t</h1>\r\n");
      out.write("\t\t<p class=\"explanation-text\" data-uia=\"explanation-text\">\r\n");
      out.write("\t\t\t<span id=\"\" data-uia=\"\">정보를 변경하기 전에 본인 확인 절차가 필요합니다.</span>\r\n");
      out.write("\t\t</p>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t<form class=\"select-factor-form\"\r\n");
      out.write("\t\t\tdata-uia=\"mfa-challenge-select-factor\" method=\"POST\">\r\n");
      out.write("\t\t\t<button type=\"button\" class=\"select-factor-button\"\r\n");
      out.write("\t\t\t\tdata-uia=\"factor-button-createSmsOtpChallengeAction\">\r\n");
      out.write("\t\t\t\t<div class=\"button-icon-wrapper\">\r\n");
      out.write("\t\t\t\t\t<svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\"\r\n");
      out.write("\t\t\t\t\t\txmlns=\"http://www.w3.org/2000/svg\" class=\"button-icon icon-chat\">\r\n");
      out.write("                    <path fill-rule=\"evenodd\" clip-rule=\"evenodd\"\r\n");
      out.write("\t\t\t\t\t\t\td=\"M18 3C21.3137 3 24 5.68629 24 9V11C24 14.3137 21.3137 17 18 17V20C18 20.3688 17.797 20.7077 17.4719 20.8817C17.1467 21.0557 16.7522 21.0366 16.4453 20.8321L11.7049 17.6718C11.0479 17.2338 10.2758 17 9.48612 17H6C2.68629 17 0 14.3137 0 11V9C0 5.68629 2.68629 3 6 3H18ZM22 9C22 6.79086 20.2091 5 18 5H6C3.79086 5 2 6.79086 2 9V11C2 13.2091 3.79086 15 6 15H9.48612C10.6707 15 11.8287 15.3506 12.8143 16.0077L16 18.1315V16V15H17H18C20.2091 15 22 13.2091 22 11V9ZM6 12C7.10457 12 8 11.1046 8 10C8 8.89543 7.10457 8 6 8C4.89543 8 4 8.89543 4 10C4 11.1046 4.89543 12 6 12ZM12 12C13.1046 12 14 11.1046 14 10C14 8.89543 13.1046 8 12 8C10.8954 8 10 8.89543 10 10C10 11.1046 10.8954 12 12 12ZM20 10C20 11.1046 19.1046 12 18 12C16.8954 12 16 11.1046 16 10C16 8.89543 16.8954 8 18 8C19.1046 8 20 8.89543 20 10Z\"\r\n");
      out.write("\t\t\t\t\t\t\tfill=\"currentColor\">\r\n");
      out.write("                    </path>\r\n");
      out.write("                  </svg>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"factor-button-text-wrapper\">\r\n");
      out.write("\t\t\t\t\t<span class=\"factor-button-primary-text\"> <span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"\">문자로 코드 받기</span></span> <span\r\n");
      out.write("\t\t\t\t\t\tclass=\"factor-button-secondary-text\">010-1234-5678</span>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"button-icon-wrapper\">\r\n");
      out.write("\t\t\t\t\t<svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\"\r\n");
      out.write("\t\t\t\t\t\txmlns=\"http://www.w3.org/2000/svg\"\r\n");
      out.write("\t\t\t\t\t\tclass=\"button-icon icon-chevron-next\">\r\n");
      out.write("                    <path fill-rule=\"evenodd\" clip-rule=\"evenodd\"\r\n");
      out.write("\t\t\t\t\t\t\td=\"M7.29297 19.2928L14.5859 12L7.29297 4.70706L8.70718 3.29285L16.7072 11.2928C16.8947 11.4804 17.0001 11.7347 17.0001 12C17.0001 12.2652 16.8947 12.5195 16.7072 12.7071L8.70718 20.7071L7.29297 19.2928Z\"\r\n");
      out.write("\t\t\t\t\t\t\tfill=\"currentColor\"></path>\r\n");
      out.write("                  </svg>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</button>\r\n");
      out.write("\t\t\t<button type=\"button\" class=\"select-factor-button\"\r\n");
      out.write("\t\t\t\tdata-uia=\"factor-button-createEmailOtpChallengeAction\">\r\n");
      out.write("\t\t\t\t<div class=\"button-icon-wrapper\">\r\n");
      out.write("\t\t\t\t\t<svg width=\"54px\" height=\"36px\" viewBox=\"0 0 54 36\"\r\n");
      out.write("\t\t\t\t\t\tclass=\"button-icon icon-email\">\r\n");
      out.write("                    <g id=\"Round-4---WEB\" stroke=\"none\" stroke-width=\"1\"\r\n");
      out.write("\t\t\t\t\t\t\tfill=\"none\" fill-rule=\"evenodd\">\r\n");
      out.write("                      <g id=\"EDR-page-nopreviousrequests-Copy-3\"\r\n");
      out.write("\t\t\t\t\t\t\ttransform=\"translate(-485.000000, -161.000000)\" stroke=\"#E50914\"\r\n");
      out.write("\t\t\t\t\t\t\tstroke-width=\"3\">\r\n");
      out.write("                        <g id=\"email\"\r\n");
      out.write("\t\t\t\t\t\t\ttransform=\"translate(487.000000, 163.000000)\">\r\n");
      out.write("                          <rect x=\"0.416666667\" y=\"0.416666667\"\r\n");
      out.write("\t\t\t\t\t\t\twidth=\"50.0555556\" height=\"31.1666667\" rx=\"3\"></rect>\r\n");
      out.write("                          <g transform=\"translate(1.000000, 0.000000)\"\r\n");
      out.write("\t\t\t\t\t\t\tstroke-linejoin=\"round\">\r\n");
      out.write("                            <polyline\r\n");
      out.write("\t\t\t\t\t\t\tpoints=\"49.2318811 0.416666667 24.4444444 20.7777754 0.657007774 0.416666667\"></polyline>\r\n");
      out.write("                          </g>\r\n");
      out.write("                        </g>\r\n");
      out.write("                      </g>\r\n");
      out.write("                    </g>\r\n");
      out.write("                  </svg>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"factor-button-text-wrapper\">\r\n");
      out.write("\t\t\t\t\t<span class=\"factor-button-primary-text\">\r\n");
      out.write("\t\t\t\t\t<a\thref=\"p07.account.jsp?profile_id=");
      out.print(Integer.parseInt(request.getParameter("profile_id")) );
      out.write("\">이메일로\t코드 받기</span> \r\n");
      out.write("\t\t\t\t\t<span class=\"factor-button-secondary-text\">");
      out.print(emailAddress );
      out.write("</span>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"button-icon-wrapper\">\r\n");
      out.write("\t\t\t\t\t<svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\"\r\n");
      out.write("\t\t\t\t\t\txmlns=\"http://www.w3.org/2000/svg\"\r\n");
      out.write("\t\t\t\t\t\tclass=\"button-icon icon-chevron-next\">\r\n");
      out.write("                    <path fill-rule=\"evenodd\" clip-rule=\"evenodd\"\r\n");
      out.write("\t\t\t\t\t\t\td=\"M7.29297 19.2928L14.5859 12L7.29297 4.70706L8.70718 3.29285L16.7072 11.2928C16.8947 11.4804 17.0001 11.7347 17.0001 12C17.0001 12.2652 16.8947 12.5195 16.7072 12.7071L8.70718 20.7071L7.29297 19.2928Z\"\r\n");
      out.write("\t\t\t\t\t\t\tfill=\"currentColor\"></path>\r\n");
      out.write("                  </svg>\r\n");
      out.write("\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</button>\r\n");
      out.write("\t\t\t<button type=\"button\" class=\"select-factor-button\"\r\n");
      out.write("\t\t\t\tdata-uia=\"factor-button-createInlineMopChallengeAction\">\r\n");
      out.write("\t\t\t\t<div class=\"button-icon-wrapper\">\r\n");
      out.write("\t\t\t\t\t<svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\"\r\n");
      out.write("\t\t\t\t\t\txmlns=\"http://www.w3.org/2000/svg\"\r\n");
      out.write("\t\t\t\t\t\tclass=\"button-icon icon-credit-card\">\r\n");
      out.write("                    <path fill-rule=\"evenodd\" clip-rule=\"evenodd\"\r\n");
      out.write("\t\t\t\t\t\t\td=\"M0 6C0 4.34315 1.34315 3 3 3H21C22.6569 3 24 4.34315 24 6V18C24 19.6569 22.6569 21 21 21H3C1.34314 21 0 19.6569 0 18V6ZM3 5C2.44772 5 2 5.44772 2 6V8H22V6C22 5.44771 21.5523 5 21 5H3ZM2 18V10H22V18C22 18.5523 21.5523 19 21 19H3C2.44772 19 2 18.5523 2 18ZM16 16H20V14H16V16Z\"\r\n");
      out.write("\t\t\t\t\t\t\tfill=\"currentColor\"></path>\r\n");
      out.write("                  </svg>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"factor-button-text-wrapper\">\r\n");
      out.write("\t\t\t\t\t<span class=\"factor-button-primary-text\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"\">결제 정보 확인</span></span><span\r\n");
      out.write("\t\t\t\t\t\tclass=\"factor-button-secondary-text\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"\">LOCAL(마지막 네 자리: 6803)</span></span>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"button-icon-wrapper\">\r\n");
      out.write("\t\t\t\t\t<svg width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\"\r\n");
      out.write("\t\t\t\t\t\txmlns=\"http://www.w3.org/2000/svg\"\r\n");
      out.write("\t\t\t\t\t\tclass=\"button-icon icon-chevron-next\">\r\n");
      out.write("                    <path fill-rule=\"evenodd\" clip-rule=\"evenodd\"\r\n");
      out.write("\t\t\t\t\t\t\td=\"M7.29297 19.2928L14.5859 12L7.29297 4.70706L8.70718 3.29285L16.7072 11.2928C16.8947 11.4804 17.0001 11.7347 17.0001 12C17.0001 12.2652 16.8947 12.5195 16.7072 12.7071L8.70718 20.7071L7.29297 19.2928Z\"\r\n");
      out.write("\t\t\t\t\t\t\tfill=\"currentColor\"></path>\r\n");
      out.write("                  </svg>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</button>\r\n");
      out.write("\t\t</form>\r\n");
      out.write("\r\n");
      out.write("\t\t<div class=\"service-text\">\r\n");
      out.write("\t\t\t<span id=\"\" data-uia=\"\">도움이 필요하신가요? <a href=\"#\"\r\n");
      out.write("\t\t\t\ttarget=\"_blank\">고객 센터로 문의하세요. </a>\r\n");
      out.write("\t\t\t</span>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<!---->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- bottom-service-center-->\t\r\n");
      out.write("\r\n");
      out.write("\t\t<div class=\"site-footer-wrapper\">\r\n");
      out.write("\t\t<div class=\"footer-divider\"></div>\r\n");
      out.write("\t\t<div class=\"site-footer\">\r\n");
      out.write("\t\t\t<p class=\"footer-top\">\r\n");
      out.write("\t\t\t\t<a class=\"footer-top-a\" href=\"https://help.netflix.com/contactus\">질문이\r\n");
      out.write("\t\t\t\t\t있으신가요? 고객 센터에 문의하세요.</a>\r\n");
      out.write("\t\t\t</p>\r\n");
      out.write("\t\t\t<ul class=\"footer-links structural\">\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-audio-and-subtitles\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_audio_and_subtitles_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"http://netflix.com/browse/subtitles/\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_audio_and_subtitles\"><span\r\n");
      out.write("\t\t\t\t\t\tid=\"\" data-uia=\"data-uia-footer-label\">음성 및 자막 </span></a></li>\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-help\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_help_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"http://help.netflix.com/\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_help\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"data-uia-footer-label\">고객 센터</span></a></li>\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-gift-card\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_gift_card_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"http://netflix.com/redeem/\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_gift_card\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"data-uia-footer-label\">기프트카드</span></a></li>\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-relations\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_relations_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"http://ir.netflix.com\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_relations\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"data-uia-footer-label\">투자 정보(IR)</span></a></li>\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-media\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_media_center_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"http://media.netflix.com\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_media_center\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"data-uia-footer-label\">미디어 센터</span></a></li>\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-jobs\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_jobs_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"http://jobs.netflix.com/\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_jobs\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"data-uia-footer-label\">입사 정보</span></a></li>\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-cookies\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_cookies_separate_link_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"http://netflix.com/Cookies/\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_cookies_separate_link\"><span\r\n");
      out.write("\t\t\t\t\t\tid=\"\" data-uia=\"data-uia-footer-label\">쿠키 설정</span></a></li>\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-terms\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_terms_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"https://help.netflix.com/legal/termsofuse\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_terms\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"data-uia-footer-label\">이용 약관</span></a></li>\r\n");
      out.write("\t\t\t\t<li class=\"footer-link-item footer-link-privacy\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_privacy_item\"><a\r\n");
      out.write("\t\t\t\t\tclass=\"footer-link\" data-uia=\"footer-link\"\r\n");
      out.write("\t\t\t\t\thref=\"https://help.netflix.com/legal/privacy\"\r\n");
      out.write("\t\t\t\t\tplaceholder=\"footer_responsive_link_privacy\"><span id=\"\"\r\n");
      out.write("\t\t\t\t\t\tdata-uia=\"data-uia-footer-label\">개인정보 처리방침</span></a></li>\r\n");
      out.write("\t\t\t</ul>\r\n");
      out.write("\t\t\t<div class=\"service-code-wrapper\" data-uia=\"service-code-wrapper\">\r\n");
      out.write("\t\t\t\t<a class=\"service-code pointer\">서비스 코드</a>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div class=\"copy-text\">\r\n");
      out.write("\t\t\t\t<div class=\"copy-text-block\">넷플릭스서비시스코리아 유한회사 통신판매업신고번호:\r\n");
      out.write("\t\t\t\t\t제2018-서울종로-0426호 전화번호:</div>\r\n");
      out.write("\t\t\t\t<div class=\"copy-text-block\">대표: 레지널드 숀 톰프슨</div>\r\n");
      out.write("\t\t\t\t<div class=\"copy-text-block\">이메일 주소: korea@netflix.com</div>\r\n");
      out.write("\t\t\t\t<div class=\"copy-text-block\">주소: 대한민국 서울특별시 종로구 우정국로 26,\r\n");
      out.write("\t\t\t\t\t센트로폴리스 A동 20층 우편번호 03161</div>\r\n");
      out.write("\t\t\t\t<div class=\"copy-text-block\">사업자등록번호: 165-87-00119</div>\r\n");
      out.write("\t\t\t\t<div class=\"copy-text-block\">클라우드 호스팅: Amazon Web Services\r\n");
      out.write("\t\t\t\t\tInc.</div>\r\n");
      out.write("\t\t\t\t<div id=\"\" class=\"copy-text-block\" data-uia=\"\">\r\n");
      out.write("\t\t\t\t\t<a style=\"color:#757575; text-decoration:none;\"href=\"\">공정거래위원회웹사이트</a>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
