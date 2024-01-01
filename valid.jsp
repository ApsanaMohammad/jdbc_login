<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>

<%
    String en;
    String ep;
    String q;
%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/apsana", "root", "apsana@777");

        // step3 create the statement object
        Statement stmt = con.createStatement();

        en = request.getParameter("ename");
        ep = request.getParameter("epwd");

        // Use prepared statement to prevent SQL injection
        String query = "select * from emp where ename=? and epwd=?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, en);
        pstmt.setString(2, ep);

        ResultSet rs = pstmt.executeQuery();

        // Display messages in HTML
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Login Result</title>");
        out.println("</head>");
        out.println("<body>");

        if (rs.next()) {
            out.println("<p>Login successful</p>");
        } else {
            out.println("<p>Check your name and password</p>");
        }

        out.println("</body>");
        out.println("</html>");

        pstmt.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
%>
