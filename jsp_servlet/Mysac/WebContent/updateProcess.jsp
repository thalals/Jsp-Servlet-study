<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.*"%>

<%@page import="javax.naming.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");	//넘어 오는거 한글처리
	
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");

	Connection conn =null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try{
		Context cp = new InitialContext();
		DataSource ds = (DataSource)cp.lookup("java:comp/env/jdbc/nov");
		conn = ds.getConnection();
		
		String temp = "select password from member where id =?";

		ps = conn.prepareStatement(temp);
		
		ps.setString(1, id);

		rs = ps.executeQuery();
		
		rs.next();
		if(rs.getString("password").equals(pass)){
			String sql ="update member set name = ?, age = ?, gender = ?, email= ? where id = ?";
			ps = conn.prepareStatement(sql);
			
			
			ps.setString(1, name);
			ps.setInt(2, age);
			ps.setString(3, gender);
			ps.setString(4, email);
			ps.setString(5, id);
			int a = ps.executeUpdate();
			
			if(a!=0){
				out.println("<script>");
				out.println("location.href='./template.jsp'");
				out.println("</script>");	
			}
			else{
				out.println("<script>");
				out.println("history.back()");
				out.println("</script>");
			}
		}
		out.println("<script>");
		out.println("history.back()");
		out.println("</script>");
	
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		if( ps != null) ps.close();
		if( conn != null) conn.close();
	}
	
%>