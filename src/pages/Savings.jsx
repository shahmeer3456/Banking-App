import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  IconButton,
  Tooltip,
  Alert,
  Grid,
} from '@mui/material';
import {
  DataGrid,
  GridToolbar,
} from '@mui/x-data-grid';
import {
  Edit as EditIcon,
  AccountBalance as AccountBalanceIcon,
} from '@mui/icons-material';
import { savingsAPI } from '../services/api';
import { useFormik } from 'formik';
import * as yup from 'yup';

const validationSchema = yup.object({
  interestRate: yup
    .number()
    .min(0, 'Interest rate must be positive')
    .max(100, 'Interest rate cannot exceed 100%')
    .required('Interest rate is required'),
  minimumBalance: yup
    .number()
    .min(0, 'Minimum balance must be positive')
    .required('Minimum balance is required'),
});

export default function Savings() {
  const [accounts, setAccounts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [editDialog, setEditDialog] = useState(false);
  const [selectedAccount, setSelectedAccount] = useState(null);
  const [error, setError] = useState('');

  useEffect(() => {
    fetchAccounts();
  }, []);

  const fetchAccounts = async () => {
    try {
      const response = await savingsAPI.getSavingsAccounts();
      setAccounts(response.data.accounts);
    } catch (error) {
      setError('Failed to fetch savings accounts');
    } finally {
      setLoading(false);
    }
  };

  const handleEditClick = (account) => {
    setSelectedAccount(account);
    setEditDialog(true);
    formik.setValues({
      interestRate: account.interestRate,
      minimumBalance: account.minimumBalance,
    });
  };

  const formik = useFormik({
    initialValues: {
      interestRate: '',
      minimumBalance: '',
    },
    validationSchema: validationSchema,
    onSubmit: async (values) => {
      try {
        await savingsAPI.updateSavingsAccount(selectedAccount.id, {
          interestRate: Number(values.interestRate),
          minimumBalance: Number(values.minimumBalance),
        });
        setEditDialog(false);
        fetchAccounts();
      } catch (error) {
        setError('Failed to update savings account');
      }
    },
  });

  const columns = [
    { field: 'id', headerName: 'Account ID', width: 130 },
    { field: 'accountNumber', headerName: 'Account Number', width: 180 },
    { field: 'accountHolder', headerName: 'Account Holder', width: 200 },
    {
      field: 'balance',
      headerName: 'Balance',
      width: 150,
      valueFormatter: (params) => `$${params.value.toLocaleString()}`,
    },
    {
      field: 'interestRate',
      headerName: 'Interest Rate',
      width: 130,
      valueFormatter: (params) => `${params.value}%`,
    },
    {
      field: 'minimumBalance',
      headerName: 'Minimum Balance',
      width: 150,
      valueFormatter: (params) => `$${params.value.toLocaleString()}`,
    },
    {
      field: 'status',
      headerName: 'Status',
      width: 130,
      renderCell: (params) => (
        <Box
          sx={{
            backgroundColor:
              params.value === 'active'
                ? 'success.light'
                : params.value === 'inactive'
                ? 'error.light'
                : 'warning.light',
            color:
              params.value === 'active'
                ? 'success.dark'
                : params.value === 'inactive'
                ? 'error.dark'
                : 'warning.dark',
            py: 0.5,
            px: 1.5,
            borderRadius: 1,
            textTransform: 'capitalize',
          }}
        >
          {params.value}
        </Box>
      ),
    },
    {
      field: 'lastInterestDate',
      headerName: 'Last Interest Credit',
      width: 180,
    },
    {
      field: 'actions',
      headerName: 'Actions',
      width: 100,
      sortable: false,
      renderCell: (params) => (
        <Box>
          <Tooltip title="Edit Account">
            <IconButton
              onClick={() => handleEditClick(params.row)}
              size="small"
              color="primary"
            >
              <EditIcon />
            </IconButton>
          </Tooltip>
        </Box>
      ),
    },
  ];

  return (
    <Box>
      <Box sx={{ display: 'flex', alignItems: 'center', mb: 3 }}>
        <AccountBalanceIcon sx={{ mr: 2, fontSize: 32, color: 'primary.main' }} />
        <Typography variant="h4">Savings Accounts</Typography>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <Card>
        <CardContent>
          <DataGrid
            rows={accounts}
            columns={columns}
            pageSize={10}
            rowsPerPageOptions={[10, 25, 50]}
            disableSelectionOnClick
            loading={loading}
            components={{
              Toolbar: GridToolbar,
            }}
            autoHeight
            sx={{ minHeight: 400 }}
          />
        </CardContent>
      </Card>

      {/* Edit Account Dialog */}
      <Dialog open={editDialog} onClose={() => setEditDialog(false)}>
        <form onSubmit={formik.handleSubmit}>
          <DialogTitle>Edit Savings Account</DialogTitle>
          <DialogContent>
            <Grid container spacing={2} sx={{ mt: 1 }}>
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  id="interestRate"
                  name="interestRate"
                  label="Interest Rate (%)"
                  type="number"
                  value={formik.values.interestRate}
                  onChange={formik.handleChange}
                  error={formik.touched.interestRate && Boolean(formik.errors.interestRate)}
                  helperText={formik.touched.interestRate && formik.errors.interestRate}
                  InputProps={{
                    endAdornment: <Typography>%</Typography>,
                  }}
                />
              </Grid>
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  id="minimumBalance"
                  name="minimumBalance"
                  label="Minimum Balance"
                  type="number"
                  value={formik.values.minimumBalance}
                  onChange={formik.handleChange}
                  error={formik.touched.minimumBalance && Boolean(formik.errors.minimumBalance)}
                  helperText={formik.touched.minimumBalance && formik.errors.minimumBalance}
                  InputProps={{
                    startAdornment: <Typography>$</Typography>,
                  }}
                />
              </Grid>
            </Grid>
          </DialogContent>
          <DialogActions>
            <Button onClick={() => setEditDialog(false)}>Cancel</Button>
            <Button type="submit" variant="contained">
              Save Changes
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    </Box>
  );
} 