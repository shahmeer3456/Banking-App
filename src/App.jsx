import React from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import { theme } from './theme';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import Layout from './components/Layout';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import Users from './pages/Users';
import Transactions from './pages/Transactions';
import AccountTypes from './pages/AccountTypes';
import Cards from './pages/Cards';
import Savings from './pages/Savings';
import Settings from './pages/Settings';

const PrivateRoute = ({ children }) => {
  const { admin, loading } = useAuth();

  if (loading) {
    return null;
  }

  return admin ? children : <Navigate to="/login" />;
};

const PublicRoute = ({ children }) => {
  const { admin, loading } = useAuth();

  if (loading) {
    return null;
  }

  return !admin ? children : <Navigate to="/dashboard" />;
};

const AppContent = () => {
  return (
    <Routes>
      <Route
        path="/login"
        element={
          <PublicRoute>
            <Login />
          </PublicRoute>
        }
      />
      <Route
        path="/dashboard"
        element={
          <PrivateRoute>
            <Layout>
              <Dashboard />
            </Layout>
          </PrivateRoute>
        }
      />
      <Route
        path="/users"
        element={
          <PrivateRoute>
            <Layout>
              <Users />
            </Layout>
          </PrivateRoute>
        }
      />
      <Route
        path="/transactions"
        element={
          <PrivateRoute>
            <Layout>
              <Transactions />
            </Layout>
          </PrivateRoute>
        }
      />
      <Route
        path="/account-types"
        element={
          <PrivateRoute>
            <Layout>
              <AccountTypes />
            </Layout>
          </PrivateRoute>
        }
      />
      <Route
        path="/cards"
        element={
          <PrivateRoute>
            <Layout>
              <Cards />
            </Layout>
          </PrivateRoute>
        }
      />
      <Route
        path="/savings"
        element={
          <PrivateRoute>
            <Layout>
              <Savings />
            </Layout>
          </PrivateRoute>
        }
      />
      <Route
        path="/settings"
        element={
          <PrivateRoute>
            <Layout>
              <Settings />
            </Layout>
          </PrivateRoute>
        }
      />
      <Route path="/" element={<Navigate to="/dashboard" replace />} />
    </Routes>
  );
};

export default function App() {
  return (
    <BrowserRouter>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <AuthProvider>
          <AppContent />
        </AuthProvider>
      </ThemeProvider>
    </BrowserRouter>
  );
} 