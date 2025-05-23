<%@ page isErrorPage="true" %>
<html>
<head><title>Error</title></head>
<body>
    <h2 style="color:red;">Something went wrong!</h2>
    <p><%= exception.getMessage() %></p>
    <a href="home.jsp">Back to Home</a>
</body>
</html>
