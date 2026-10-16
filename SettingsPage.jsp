<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("userEmail") == null) {
        response.sendRedirect("LoginPage.html?error=session_expired");
        return;
    }
    String userName = (session.getAttribute("userName") != null) ? session.getAttribute("userName").toString() : "Explorer";
    String userEmail = session.getAttribute("userEmail").toString();
    String err = request.getParameter("error");
    String update = request.getParameter("update");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings - StreamVerse</title>
    <link rel="stylesheet" href="HomePage.css">
    <link rel="stylesheet" href="LoginPage.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body style="display: block; padding: 0;">

    <!-- Top Navigation Header -->
    <header class="header">
        <div class="header-left">
            <a href="home" class="logo">
                <span class="material-icons yt-icon">smart_display</span>
                <span class="logo-text">StreamVerse</span>
            </a>
        </div>
        <div class="header-right">
            <div class="user-avatar" title="<%= userEmail %>">
                <%= userName.substring(0, 1).toUpperCase() %>
            </div>
            <a href="home" class="signin-btn">
                <span class="material-icons">arrow_back</span> Return Home
            </a>
        </div>
    </header>

    <!-- Settings Form Layout -->
    <div style="min-height: calc(100vh - 64px); display: flex; justify-content: center; align-items: center; padding: 40px 20px; position: relative; z-index: 1;">
        <div class="login-card" style="max-width: 450px;">
            <h2>Account Security</h2>

            <div style="background: var(--input-surface); border: 1px solid var(--border-input); border-radius: 12px; padding: 14px 16px; margin-bottom: 20px; font-size: 13.5px; line-height: 1.6;">
                <div><span style="color: var(--text-muted);">Active Pilot: </span><strong><%= userName %></strong></div>
                <div><span style="color: var(--text-muted);">Account ID: </span><span style="color: var(--color-cyan);"><%= userEmail %></span></div>
            </div>

            <% if ("success".equals(update)) { %>
                <div class="status-msg success" style="display: block;">
                    Security password updated successfully!
                </div>
            <% } else if ("password_mismatch".equals(err)) { %>
                <div class="status-msg error" style="display: block;">
                    New confirmation password does not match.
                </div>
            <% } else if ("invalid_current_password".equals(err)) { %>
                <div class="status-msg error" style="display: block;">
                    Current password provided is incorrect.
                </div>
            <% } else if ("missing_fields".equals(err)) { %>
                <div class="status-msg error" style="display: block;">
                    Please fill out all password fields.
                </div>
            <% } %>

            <form action="UpdatePasswordServlet" method="POST">
                <div class="form-group">
                    <label for="current_pwd">Current Security Password</label>
                    <input type="password" id="current_pwd" name="current_pwd" placeholder="••••••••" required>
                </div>

                <div class="form-group">
                    <label for="new_pwd_1">New Security Password</label>
                    <input type="password" id="new_pwd_1" name="new_pwd_1" placeholder="••••••••" required minlength="6">
                </div>

                <div class="form-group">
                    <label for="new_pwd_2">Confirm New Password</label>
                    <input type="password" id="new_pwd_2" name="new_pwd_2" placeholder="••••••••" required minlength="6">
                </div>

                <button type="submit" class="submit-btn">Save Changes</button>
            </form>

            <div class="links">
                <a href="home">Back to Stream Workspace</a>
            </div>
        </div>
    </div>

</body>
</html>