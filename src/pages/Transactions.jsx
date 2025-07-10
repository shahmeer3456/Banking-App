import React, { useState, useEffect } from 'react';
import {
  Box,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Typography,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  IconButton,
  Alert
} from '@mui/material';
import { Add as AddIcon, Visibility as VisibilityIcon } from '@mui/icons-material';
import api from '../services/api';

const Transactions = () => {
  const [transactions, setTransactions] = useState([]);
  const [accounts, setAccounts] = useState([]);
  const [openDepositDialog, setOpenDepositDialog] = useState(false);
  const [openWithdrawDialog, setOpenWithdrawDialog] = useState(false);
  const [selectedAccount, setSelectedAccount] = useState('');
  const [amount, setAmount] = useState('');
  const [chequeNumber, setChequeNumber] = useState('');
  const [notes, setNotes] = useState('');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  useEffect(() => {
    fetchTransactions();
    fetchAccounts();
  }, []);

  const fetchTransactions = async () => {
    try {
      const response = await api.get('/transactions');
      setTransactions(response.data);
    } catch (error) {
      setError('Failed to fetch transactions');
    }
  };

  const fetchAccounts = async () => {
    try {
      const response = await api.get('/admin/accounts');
      setAccounts(response.data);
    } catch (error) {
      setError('Failed to fetch accounts');
    }
  };

  const handleDeposit = async () => {
    try {
      const response = await api.post('/admin/deposit', {
        accountId: selectedAccount,
        amount: parseFloat(amount),
        notes
      });

      setSuccess('Deposit successful');
      fetchTransactions();
      handleCloseDepositDialog();
    } catch (error) {
      setError(error.response?.data?.message || 'Failed to process deposit');
    }
  };

  const handleWithdraw = async () => {
    try {
      const response = await api.post('/admin/withdraw', {
        accountId: selectedAccount,
        amount: parseFloat(amount),
        chequeNumber,
        notes
      });

      setSuccess('Withdrawal successful');
      fetchTransactions();
      handleCloseWithdrawDialog();
    } catch (error) {
      setError(error.response?.data?.message || 'Failed to process withdrawal');
    }
  };

  const handleCloseDepositDialog = () => {
    setOpenDepositDialog(false);
    resetForm();
  };

  const handleCloseWithdrawDialog = () => {
    setOpenWithdrawDialog(false);
    resetForm();
  };

  const resetForm = () => {
    setSelectedAccount('');
    setAmount('');
    setChequeNumber('');
    setNotes('');
    setError('');
  };

  return (
    <Box p={3}>
      <Box display="flex" justifyContent="space-between" mb={3}>
        <Typography variant="h4">Transactions</Typography>
        <Box>
          <Button
            variant="contained"
            color="primary"
            startIcon={<AddIcon />}
            onClick={() => setOpenDepositDialog(true)}
            sx={{ mr: 2 }}
          >
            Cash Deposit
          </Button>
          <Button
            variant="contained"
            color="secondary"
            startIcon={<AddIcon />}
            onClick={() => setOpenWithdrawDialog(true)}
          >
            Cheque Withdrawal
          </Button>
        </Box>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      {success && (
        <Alert severity="success" sx={{ mb: 2 }}>
          {success}
        </Alert>
      )}

      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Date</TableCell>
              <TableCell>Account</TableCell>
              <TableCell>Type</TableCell>
              <TableCell>Method</TableCell>
              <TableCell>Amount</TableCell>
              <TableCell>Status</TableCell>
              <TableCell>Notes</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {transactions.map((transaction) => (
              <TableRow key={transaction._id}>
                <TableCell>{new Date(transaction.createdAt).toLocaleDateString()}</TableCell>
                <TableCell>{transaction.account.user.name}</TableCell>
                <TableCell>{transaction.type}</TableCell>
                <TableCell>{transaction.method}</TableCell>
                <TableCell>${transaction.amount.toFixed(2)}</TableCell>
                <TableCell>{transaction.status}</TableCell>
                <TableCell>{transaction.notes}</TableCell>
                <TableCell>
                  <IconButton>
                    <VisibilityIcon />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      {/* Deposit Dialog */}
      <Dialog open={openDepositDialog} onClose={handleCloseDepositDialog}>
        <DialogTitle>Cash Deposit</DialogTitle>
        <DialogContent>
          <FormControl fullWidth sx={{ mt: 2 }}>
            <InputLabel>Account</InputLabel>
            <Select
              value={selectedAccount}
              onChange={(e) => setSelectedAccount(e.target.value)}
            >
              {accounts.map((account) => (
                <MenuItem key={account._id} value={account._id}>
                  {account.user.name} - {account.accountType}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
          <TextField
            fullWidth
            label="Amount"
            type="number"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            sx={{ mt: 2 }}
          />
          <TextField
            fullWidth
            label="Notes"
            multiline
            rows={2}
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            sx={{ mt: 2 }}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDepositDialog}>Cancel</Button>
          <Button onClick={handleDeposit} variant="contained" color="primary">
            Deposit
          </Button>
        </DialogActions>
      </Dialog>

      {/* Withdraw Dialog */}
      <Dialog open={openWithdrawDialog} onClose={handleCloseWithdrawDialog}>
        <DialogTitle>Cheque Withdrawal</DialogTitle>
        <DialogContent>
          <FormControl fullWidth sx={{ mt: 2 }}>
            <InputLabel>Account</InputLabel>
            <Select
              value={selectedAccount}
              onChange={(e) => setSelectedAccount(e.target.value)}
            >
              {accounts.map((account) => (
                <MenuItem key={account._id} value={account._id}>
                  {account.user.name} - {account.accountType}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
          <TextField
            fullWidth
            label="Amount"
            type="number"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            sx={{ mt: 2 }}
          />
          <TextField
            fullWidth
            label="Cheque Number"
            value={chequeNumber}
            onChange={(e) => setChequeNumber(e.target.value)}
            sx={{ mt: 2 }}
          />
          <TextField
            fullWidth
            label="Notes"
            multiline
            rows={2}
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            sx={{ mt: 2 }}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseWithdrawDialog}>Cancel</Button>
          <Button onClick={handleWithdraw} variant="contained" color="secondary">
            Withdraw
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default Transactions; 