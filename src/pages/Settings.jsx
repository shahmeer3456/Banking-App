import React, { useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Switch,
  List,
  ListItem,
  ListItemText,
  ListItemSecondaryAction,
  Divider,
  Alert,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
} from '@mui/material';
import {
  Notifications as NotificationsIcon,
  Security as SecurityIcon,
  Language as LanguageIcon,
  Palette as PaletteIcon,
} from '@mui/icons-material';

export default function Settings() {
  const [settings, setSettings] = useState({
    emailNotifications: true,
    pushNotifications: false,
    twoFactorAuth: true,
    darkMode: false,
    language: 'English',
    timezone: 'UTC',
  });

  const [passwordDialog, setPasswordDialog] = useState(false);
  const [error, setError] = useState('');

  const handleSettingChange = (setting) => (event) => {
    setSettings((prev) => ({
      ...prev,
      [setting]: event.target.checked,
    }));
  };

  const handlePasswordChange = (event) => {
    event.preventDefault();
    // Implement password change logic here
    setPasswordDialog(false);
  };

  return (
    <Box>
      <Typography variant="h4" gutterBottom>
        Settings
      </Typography>

      {error && (
        <Alert severity="error" sx={{ mb: 2 }}>
          {error}
        </Alert>
      )}

      <Box sx={{ display: 'grid', gap: 3 }}>
        {/* Notifications */}
        <Card>
          <CardContent>
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
              <NotificationsIcon sx={{ mr: 1 }} />
              <Typography variant="h6">Notifications</Typography>
            </Box>
            <List>
              <ListItem>
                <ListItemText
                  primary="Email Notifications"
                  secondary="Receive email alerts for important events"
                />
                <ListItemSecondaryAction>
                  <Switch
                    edge="end"
                    checked={settings.emailNotifications}
                    onChange={handleSettingChange('emailNotifications')}
                  />
                </ListItemSecondaryAction>
              </ListItem>
              <Divider />
              <ListItem>
                <ListItemText
                  primary="Push Notifications"
                  secondary="Receive push notifications for real-time updates"
                />
                <ListItemSecondaryAction>
                  <Switch
                    edge="end"
                    checked={settings.pushNotifications}
                    onChange={handleSettingChange('pushNotifications')}
                  />
                </ListItemSecondaryAction>
              </ListItem>
            </List>
          </CardContent>
        </Card>

        {/* Security */}
        <Card>
          <CardContent>
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
              <SecurityIcon sx={{ mr: 1 }} />
              <Typography variant="h6">Security</Typography>
            </Box>
            <List>
              <ListItem>
                <ListItemText
                  primary="Two-Factor Authentication"
                  secondary="Add an extra layer of security to your account"
                />
                <ListItemSecondaryAction>
                  <Switch
                    edge="end"
                    checked={settings.twoFactorAuth}
                    onChange={handleSettingChange('twoFactorAuth')}
                  />
                </ListItemSecondaryAction>
              </ListItem>
              <Divider />
              <ListItem>
                <ListItemText
                  primary="Change Password"
                  secondary="Update your account password"
                />
                <ListItemSecondaryAction>
                  <Button
                    variant="outlined"
                    size="small"
                    onClick={() => setPasswordDialog(true)}
                  >
                    Change
                  </Button>
                </ListItemSecondaryAction>
              </ListItem>
            </List>
          </CardContent>
        </Card>

        {/* Appearance */}
        <Card>
          <CardContent>
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
              <PaletteIcon sx={{ mr: 1 }} />
              <Typography variant="h6">Appearance</Typography>
            </Box>
            <List>
              <ListItem>
                <ListItemText
                  primary="Dark Mode"
                  secondary="Toggle dark mode theme"
                />
                <ListItemSecondaryAction>
                  <Switch
                    edge="end"
                    checked={settings.darkMode}
                    onChange={handleSettingChange('darkMode')}
                  />
                </ListItemSecondaryAction>
              </ListItem>
            </List>
          </CardContent>
        </Card>

        {/* Localization */}
        <Card>
          <CardContent>
            <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
              <LanguageIcon sx={{ mr: 1 }} />
              <Typography variant="h6">Localization</Typography>
            </Box>
            <List>
              <ListItem>
                <ListItemText
                  primary="Language"
                  secondary={settings.language}
                />
                <ListItemSecondaryAction>
                  <Button variant="outlined" size="small">
                    Change
                  </Button>
                </ListItemSecondaryAction>
              </ListItem>
              <Divider />
              <ListItem>
                <ListItemText
                  primary="Time Zone"
                  secondary={settings.timezone}
                />
                <ListItemSecondaryAction>
                  <Button variant="outlined" size="small">
                    Change
                  </Button>
                </ListItemSecondaryAction>
              </ListItem>
            </List>
          </CardContent>
        </Card>
      </Box>

      {/* Change Password Dialog */}
      <Dialog open={passwordDialog} onClose={() => setPasswordDialog(false)}>
        <form onSubmit={handlePasswordChange}>
          <DialogTitle>Change Password</DialogTitle>
          <DialogContent>
            <TextField
              fullWidth
              type="password"
              label="Current Password"
              margin="normal"
              required
            />
            <TextField
              fullWidth
              type="password"
              label="New Password"
              margin="normal"
              required
            />
            <TextField
              fullWidth
              type="password"
              label="Confirm New Password"
              margin="normal"
              required
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={() => setPasswordDialog(false)}>Cancel</Button>
            <Button type="submit" variant="contained">
              Change Password
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    </Box>
  );
} 