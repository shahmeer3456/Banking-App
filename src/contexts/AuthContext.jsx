import React, { createContext, useContext, useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import jwt_decode from 'jwt-decode';
import { authAPI } from '../services/api';

const AuthContext = createContext(null);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

export const AuthProvider = ({ children }) => {
  const [admin, setAdmin] = useState(null);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    checkAuth();
  }, []);

  const checkAuth = async () => {
    try {
      const token = localStorage.getItem('admin_token');
      if (token) {
        const decoded = jwt_decode(token);
        if (decoded.exp * 1000 > Date.now()) {
          await authAPI.verifyToken();
          setAdmin(decoded);
        } else {
          handleLogout();
        }
      }
    } catch (error) {
      handleLogout();
    } finally {
      setLoading(false);
    }
  };

  const handleLogin = async (credentials) => {
    try {
      const response = await authAPI.login(credentials);
      const { token } = response.data;
      localStorage.setItem('admin_token', token);
      const decoded = jwt_decode(token);
      setAdmin(decoded);
      navigate('/dashboard');
      return { success: true };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || 'Login failed',
      };
    }
  };

  const handleLogout = () => {
    localStorage.removeItem('admin_token');
    setAdmin(null);
    navigate('/login');
  };

  const value = {
    admin,
    loading,
    login: handleLogin,
    logout: handleLogout,
  };

  if (loading) {
    return (
      <div style={{ 
        display: 'flex', 
        justifyContent: 'center', 
        alignItems: 'center', 
        height: '100vh' 
      }}>
        Loading...
      </div>
    );
  }

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
}; 