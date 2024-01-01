<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>

<%
    String en;
    String ep;
    int sal;
    int age;
    String q;
%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");

        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/apsana", "root", "apsana@777");

        // Step 3: Create the PreparedStatement object with placeholders
        en = request.getParameter("ename");
        ep = request.getParameter("epwd");
        age = Integer.parseInt(request.getParameter("eage"));
        sal = Integer.parseInt(request.getParameter("esal"));

        // Use prepared statement to prevent SQL injection
        String query = "insert into emp values(?,?,?,?)";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, en);
        pstmt.setString(2, ep);
        pstmt.setInt(3, sal);
        pstmt.setInt(4, age);

        // Step 4: Execute the query
        int rowsAffected = pstmt.executeUpdate();

        // Display messages in HTML
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Login Result</title>");
        out.println("</head>");
        out.println("<body>");

        // Step 5: Check for Successful Insertion
        if (rowsAffected > 0) {
            out.println("<p>Signup successful</p>");
        } else {
            out.println("<p>Fill all the fields</p>");
        }

        out.println("</body>");
        out.println("</html>");

        // Step 6: Close resources
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("An error occurred: " + e.getMessage());
    }
%>
