<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%= request.getContextPath() %>/GetAllItems" method="GET">
		<button type="submit">Items</button>
	</form>
	<br>
	<form action="<%= request.getContextPath() %>/GetItemById" method="GET">
		<input type="text" name="itemId">
		<button type="submit">Get Item</button>
	</form>
	<br>
	<form action="<%= request.getContextPath() %>/CreateItem" method="GET">
		<button type="submit">Create Item</button>
	</form>
	<br>
	<form action="<%= request.getContextPath() %>/UpdateItem" method="GET">
		<input type="text" name="itemId">
		<button type="submit">Update Item</button>
	</form>
	<br>
	<form action="<%= request.getContextPath() %>/DeleteItem" method="POST">
		<input type="text" name="itemId">
		<button type="submit">Delete Item</button>
	</form>
</body>
</html>