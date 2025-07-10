import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000/api';

const api = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json'
    }
});

// Add token to requests if it exists
api.interceptors.request.use((config) => {
    const token = localStorage.getItem('adminToken');
    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
});

export const adminApi = {
    // Auth
    login: async (email, password) => {
        const response = await api.post('/auth/admin/login', { email, password });
        return response.data;
    },

    // Users
    getUsers: async () => {
        const response = await api.get('/admin/users');
        return response.data;
    },

    getUser: async (userId) => {
        const response = await api.get(`/admin/users/${userId}`);
        return response.data;
    },

    updateUser: async (userId, userData) => {
        const response = await api.put(`/admin/users/${userId}`, userData);
        return response.data;
    },

    deleteUser: async (userId) => {
        const response = await api.delete(`/admin/users/${userId}`);
        return response.data;
    },

    // Transactions
    getTransactions: async () => {
        const response = await api.get('/admin/transactions');
        return response.data;
    },

    getTransaction: async (transactionId) => {
        const response = await api.get(`/admin/transactions/${transactionId}`);
        return response.data;
    },

    updateTransactionStatus: async (transactionId, status) => {
        const response = await api.put(`/admin/transactions/${transactionId}/status`, { status });
        return response.data;
    }
};

export default adminApi; 