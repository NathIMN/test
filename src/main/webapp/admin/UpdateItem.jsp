<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Item Details</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .make {
            margin-left: 20px;
            font-weight: bold;
        }

        .model {
            margin-left: 40px;
        }

        .year {
            margin-left: 60px;
            color: #666;
        }
    </style>
</head>

<body>
    <h1>Item Details</h1>
    <form action="<%= request.getContextPath() %>/UpdateItem" method="POST">
	    <table>
	        <tr>
	            <th>ID</th>
	            <td><input type="number" value="${item.itemId}" name="itemId"></td>
	        </tr>
	        <tr>
	            <th>Name</th>
	            <td><input type="text" value="${item.itemName}" name="itemName"></td>
	        </tr>
	        <tr>
	            <th>Brand</th>
	            <td><input type="text" value="${item.itemBrand}" name="itemBrand"></td>
	        </tr>
	        <tr>
	            <th>Category</th>
	            <td><input type="text" value="${item.itemCategory}" name="itemCategory"></td>
	        </tr>
	        <tr>
	            <th>Price</th>
	            <td><input type="number" step="0.01" value="${item.itemPrice}" name="itemPrice"></td>
	        </tr>
	        <tr>
	            <th>Stock</th>
	            <td><input type="number" value="${item.itemStocks}" name="itemStocks"></td>
	        </tr>
	    </table>
	    <button type="submit">Update</button>
    </form>
</body>

</html>
