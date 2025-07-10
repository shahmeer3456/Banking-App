import React, { useState, useEffect } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Grid,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  List,
  ListItem,
  ListItemText,
  Divider,
  Alert,
  IconButton,
  Accordion,
  AccordionSummary,
  AccordionDetails,
  Chip
} from '@mui/material';
import {
  Edit as EditIcon,
  ExpandMore as ExpandMoreIcon,
  Add as AddIcon
} from '@mui/icons-material';
import api from '../services/api';

const AccountTypes = () => {
  const [accountTypes, setAccountTypes] = useState({});
  const [terms, setTerms] = useState({});
  const [selectedType, setSelectedType] = useState(null);
  const [openTermsDialog, setOpenTermsDialog] = useState(false);
  const [editingTerms, setEditingTerms] = useState({
    generalTerms: [],
    accountSpecificTerms: [],
    feesAndCharges: [],
    benefitsAndPrivileges: []
  });
  const [version, setVersion] = useState('');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  useEffect(() => {
    fetchAccountTypes();
    fetchAllTerms();
  }, []);

  const fetchAccountTypes = async () => {
    try {
      const response = await api.get('/admin/account-types');
      setAccountTypes(response.data);
    } catch (error) {
      setError('Failed to fetch account types');
    }
  };

  const fetchAllTerms = async () => {
    try {
      const types = ['premium', 'gold', 'silver', 'classic'];
      const termsData = {};
      
      for (const type of types) {
        const response = await api.get(`/admin/terms/${type}`);
        termsData[type] = response.data;
      }
      
      setTerms(termsData);
    } catch (error) {
      setError('Failed to fetch terms and conditions');
    }
  };

  const handleEditTerms = (type) => {
    setSelectedType(type);
    setEditingTerms(terms[type]);
    setVersion(new Date().toISOString().split('T')[0] + '-v1');
    setOpenTermsDialog(true);
  };

  const handleSaveTerms = async () => {
    try {
      await api.post('/admin/terms', {
        accountType: selectedType,
        version,
        ...editingTerms
      });

      setSuccess('Terms updated successfully');
      fetchAllTerms();
      setOpenTermsDialog(false);
    } catch (error) {
      setError('Failed to update terms');
    }
  };

  const handleTermChange = (field, index, value) => {
    setEditingTerms(prev => ({
      ...prev,
      [field]: prev[field].map((item, i) => i === index ? value : item)
    }));
  };

  const handleAddTerm = (field) => {
    setEditingTerms(prev => ({
      ...prev,
      [field]: [...prev[field], '']
    }));
  };

  const handleRemoveTerm = (field, index) => {
    setEditingTerms(prev => ({
      ...prev,
      [field]: prev[field].filter((_, i) => i !== index)
    }));
  };

  return (
    <Box p={3}>
      <Typography variant="h4" gutterBottom>
        Account Types Management
      </Typography>

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

      <Grid container spacing={3}>
        {Object.entries(accountTypes).map(([type, details]) => (
          <Grid item xs={12} md={6} key={type}>
            <Card>
              <CardContent>
                <Box display="flex" justifyContent="space-between" alignItems="center" mb={2}>
                  <Typography variant="h5" component="h2">
                    {details.name}
                    <Chip
                      label={type}
                      size="small"
                      sx={{ ml: 1 }}
                      color={type === 'premium' ? 'primary' : 'default'}
                    />
                  </Typography>
                  <Button
                    variant="outlined"
                    startIcon={<EditIcon />}
                    onClick={() => handleEditTerms(type)}
                  >
                    Edit Terms
                  </Button>
                </Box>

                <Typography color="textSecondary" gutterBottom>
                  {details.description}
                </Typography>

                <Accordion>
                  <AccordionSummary expandIcon={<ExpandMoreIcon />}>
                    <Typography>Features & Benefits</Typography>
                  </AccordionSummary>
                  <AccordionDetails>
                    <List dense>
                      {details.features.map((feature, index) => (
                        <ListItem key={index}>
                          <ListItemText primary={feature} />
                        </ListItem>
                      ))}
                    </List>
                  </AccordionDetails>
                </Accordion>

                <Box mt={2}>
                  <Typography variant="subtitle1">
                    Minimum Balance: ${details.minimumBalance}
                  </Typography>
                  <Typography variant="subtitle1">
                    Monthly Fee: ${details.monthlyFee}
                  </Typography>
                </Box>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>

      <Dialog
        open={openTermsDialog}
        onClose={() => setOpenTermsDialog(false)}
        maxWidth="md"
        fullWidth
      >
        <DialogTitle>
          Edit Terms & Conditions - {selectedType?.charAt(0).toUpperCase() + selectedType?.slice(1)}
        </DialogTitle>
        <DialogContent>
          <TextField
            fullWidth
            label="Version"
            value={version}
            onChange={(e) => setVersion(e.target.value)}
            margin="normal"
          />

          {['generalTerms', 'accountSpecificTerms', 'feesAndCharges', 'benefitsAndPrivileges'].map((field) => (
            <Box key={field} mt={3}>
              <Typography variant="h6" gutterBottom>
                {field.split(/(?=[A-Z])/).join(' ')}
                <IconButton size="small" onClick={() => handleAddTerm(field)}>
                  <AddIcon />
                </IconButton>
              </Typography>
              {editingTerms[field].map((term, index) => (
                <TextField
                  key={index}
                  fullWidth
                  multiline
                  value={term}
                  onChange={(e) => handleTermChange(field, index, e.target.value)}
                  margin="dense"
                  InputProps={{
                    endAdornment: (
                      <Button
                        size="small"
                        color="error"
                        onClick={() => handleRemoveTerm(field, index)}
                      >
                        Remove
                      </Button>
                    ),
                  }}
                />
              ))}
            </Box>
          ))}
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setOpenTermsDialog(false)}>Cancel</Button>
          <Button onClick={handleSaveTerms} variant="contained" color="primary">
            Save Terms
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default AccountTypes; 