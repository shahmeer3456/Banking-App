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
  MenuItem,
  Grid,
} from '@mui/material';
import {
  DataGrid,
  GridToolbar,
} from '@mui/x-data-grid';
import {
  CreditCard as CreditCardIcon,
  Block as BlockIcon,
  CheckCircle as CheckCircleIcon,
  Add as AddIcon,
} from '@mui/icons-material';
import { cardsAPI, usersAPI } from '../services/api';
import { useFormik } from 'formik';
import * as yup from 'yup';

const validationSchema = yup.object({
  userId: yup.string().required('User is required'),
  cardType: yup.string().required('Card type is required'),
  cardLimit: yup.number().min(0, 'Limit must be positive').required('Card limit is required'),
});

export default function Cards() {
  const [cards, setCards] = useState([]);
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [issueDialog, setIssueDialog] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const [cardsRes, usersRes] = await Promise.all([
        cardsAPI.getCards(),
        usersAPI.getUsers(),
      ]);
      setCards(cardsRes.data.cards);
      setUsers(usersRes.data.users);
    } catch (error) {
      setError('Failed to fetch data');
    } finally {
      setLoading(false);
    }
  };

  const handleStatusChange = async (cardId, newStatus) => {
    try {
      await cardsAPI.updateCard(cardId, { status: newStatus });
      fetchData();
    } catch (error) {
      setError('Failed to update card status');
    }
  };

  const formik = useFormik({
    initialValues: {
      userId: '',
      cardType: '',
      cardLimit: '',
    },
    validationSchema: validationSchema,
    onSubmit: async (values) => {
      try {
        await cardsAPI.issueCard(values.userId, {
          type: values.cardType,
          limit: Number(values.cardLimit),
        });
        setIssueDialog(false);
        fetchData();
      } catch (error) {
        setError('Failed to issue card');
      }
    },
  });

  const cardTypes = [
    { value: 'debit', label: 'Debit Card' },
    { value: 'credit', label: 'Credit Card' },
    { value: 'prepaid', label: 'Prepaid Card' },
  ];

  const columns = [
    { field: 'id', headerName: 'Card ID', width: 130 },
    { field: 'cardNumber', headerName: 'Card Number', width: 200 },
    { field: 'cardholderName', headerName: 'Cardholder', width: 180 },
    { field: 'cardType', headerName: 'Type', width: 130 },
    {
      field: 'cardLimit',
      headerName: 'Limit',
      width: 130,
      valueFormatter: (params) => 
        params.value ? `$${params.value.toLocaleString()}` : 'N/A',
    },
    {
      field: 'expiryDate',
      headerName: 'Expiry',
      width: 130,
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
                : params.value === 'blocked'
                ? 'error.light'
                : 'warning.light',
            color:
              params.value === 'active'
                ? 'success.dark'
                : params.value === 'blocked'
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
      field: 'actions',
      headerName: 'Actions',
      width: 130,
      sortable: false,
      renderCell: (params) => (
        <Box>
          {params.row.status === 'active' ? (
            <Tooltip title="Block Card">
              <IconButton
                onClick={() => handleStatusChange(params.row.id, 'blocked')}
                size="small"
                color="error"
              >
                <BlockIcon />
              </IconButton>
            </Tooltip>
          ) : (
            <Tooltip title="Activate Card">
              <IconButton
                onClick={() => handleStatusChange(params.row.id, 'active')}
                size="small"
                color="success"
              >
                <CheckCircleIcon />
              </IconButton>
            </Tooltip>
          )}
        </Box>
      ),
    },
  ];

  return (
    <Box>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 3 }}>
        <Typography variant="h4">Card Management</Typography>
        <Button
          variant="contained"
          startIcon={<AddIcon />}
          onClick={() => setIssueDialog(true)}
        >
          Issue New Card
        </Button>
      </Box>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <Card>
        <CardContent>
          <DataGrid
            rows={cards}
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

      {/* Issue Card Dialog */}
      <Dialog open={issueDialog} onClose={() => setIssueDialog(false)}>
        <form onSubmit={formik.handleSubmit}>
          <DialogTitle>Issue New Card</DialogTitle>
          <DialogContent>
            <Grid container spacing={2} sx={{ mt: 1 }}>
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  id="userId"
                  name="userId"
                  label="Select User"
                  select
                  value={formik.values.userId}
                  onChange={formik.handleChange}
                  error={formik.touched.userId && Boolean(formik.errors.userId)}
                  helperText={formik.touched.userId && formik.errors.userId}
                >
                  {users.map((user) => (
                    <MenuItem key={user.id} value={user.id}>
                      {user.fullName}
                    </MenuItem>
                  ))}
                </TextField>
              </Grid>
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  id="cardType"
                  name="cardType"
                  label="Card Type"
                  select
                  value={formik.values.cardType}
                  onChange={formik.handleChange}
                  error={formik.touched.cardType && Boolean(formik.errors.cardType)}
                  helperText={formik.touched.cardType && formik.errors.cardType}
                >
                  {cardTypes.map((type) => (
                    <MenuItem key={type.value} value={type.value}>
                      {type.label}
                    </MenuItem>
                  ))}
                </TextField>
              </Grid>
              <Grid item xs={12}>
                <TextField
                  fullWidth
                  id="cardLimit"
                  name="cardLimit"
                  label="Card Limit"
                  type="number"
                  value={formik.values.cardLimit}
                  onChange={formik.handleChange}
                  error={formik.touched.cardLimit && Boolean(formik.errors.cardLimit)}
                  helperText={formik.touched.cardLimit && formik.errors.cardLimit}
                  InputProps={{
                    startAdornment: <Typography>$</Typography>,
                  }}
                />
              </Grid>
            </Grid>
          </DialogContent>
          <DialogActions>
            <Button onClick={() => setIssueDialog(false)}>Cancel</Button>
            <Button type="submit" variant="contained">
              Issue Card
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    </Box>
  );
} 