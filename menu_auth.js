// API Base URL
const API_BASE_URL = window.location.hostname === 'localhost' 
    ? 'http://localhost/-WebTechFinals' 
    : '';

// Check if user is logged in and verify session
window.onload = async function() {
    const userDataStr = sessionStorage.getItem('brightMindsUser');
    
    if (!userDataStr) {
        // No session data, redirect to login
        window.location.href = 'index.html';
        return;
    }
    
    try {
        const userData = JSON.parse(userDataStr);
        
        // Verify session with server if sessionToken exists
        if (userData.sessionToken) {
            const response = await fetch(`${API_BASE_URL}/verify_session.php`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    sessionToken: userData.sessionToken
                })
            });
            
            const data = await response.json();
            
            if (!data.success) {
                // Session invalid, redirect to login
                sessionStorage.removeItem('brightMindsUser');
                alert('Your session has expired. Please login again.');
                window.location.href = 'index.html';
                return;
            }
            
            // Update user data with fresh data from server
            userData.username = data.user.username;
            userData.email = data.user.email;
            userData.avatar = data.user.avatar;
            userData.avatarName = data.user.avatarName;
            sessionStorage.setItem('brightMindsUser', JSON.stringify(userData));
        }
        
        // Display welcome message
        document.getElementById('welcomeMessage').textContent = `Welcome, ${userData.username}! ${userData.avatarName}`;
        
    } catch (error) {
        console.error('Session verification error:', error);
        // On error, redirect to login
        sessionStorage.removeItem('brightMindsUser');
        window.location.href = 'index.html';
    }
};

async function logout() {
    if (!confirm('Are you sure you want to logout?')) {
        return;
    }
    
    const userDataStr = sessionStorage.getItem('brightMindsUser');
    
    if (userDataStr) {
        try {
            const userData = JSON.parse(userDataStr);
            
            if (userData.sessionToken) {
                // Call logout API to delete session from database
                await fetch(`${API_BASE_URL}/logout.php`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        sessionToken: userData.sessionToken
                    })
                });
            }
        } catch (error) {
            console.error('Logout error:', error);
        }
    }
    
    // Clear session storage and redirect
    sessionStorage.removeItem('brightMindsUser');
    window.location.href = 'index.html';
}