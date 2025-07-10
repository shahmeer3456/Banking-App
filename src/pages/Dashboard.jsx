import React, { useState, useEffect } from 'react';
import {
  Box,
  Grid,
  Card,
  CardContent,
  Typography,
  Button,
  ButtonGroup,
  CircularProgress,
} from '@mui/material';
import {
  TrendingUp as TrendingUpIcon,
  People as PeopleIcon,
  AccountBalance as AccountBalanceIcon,
  CreditCard as CreditCardIcon,
} from '@mui/icons-material';
import { ResponsiveLine } from '@nivo/line';
import { ResponsivePie } from '@nivo/pie';
import { dashboardAPI } from '../services/api';

const StatCard = ({ title, value, icon, trend, loading }) => (
  <Card>
    <CardContent>
      <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
        {icon}
        <Typography variant="h6" sx={{ ml: 1 }}>
          {title}
        </Typography>
      </Box>
      {loading ? (
        <CircularProgress size={20} />
      ) : (
        <>
          <Typography variant="h4">{value}</Typography>
          {trend && (
            <Typography
              variant="body2"
              color={trend >= 0 ? 'success.main' : 'error.main'}
              sx={{ display: 'flex', alignItems: 'center', mt: 1 }}
            >
              <TrendingUpIcon
                sx={{
                  mr: 0.5,
                  transform: trend >= 0 ? 'none' : 'rotate(180deg)',
                }}
              />
              {Math.abs(trend)}% from last period
            </Typography>
          )}
        </>
      )}
    </CardContent>
  </Card>
);

export default function Dashboard() {
  const [stats, setStats] = useState(null);
  const [transactionData, setTransactionData] = useState(null);
  const [userStats, setUserStats] = useState(null);
  const [period, setPeriod] = useState('week');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchDashboardData();
  }, [period]);

  const fetchDashboardData = async () => {
    setLoading(true);
    try {
      const [statsRes, transactionsRes, usersRes] = await Promise.all([
        dashboardAPI.getStats(),
        dashboardAPI.getTransactionStats(period),
        dashboardAPI.getUserStats(period),
      ]);

      setStats(statsRes.data);
      setTransactionData(transactionsRes.data);
      setUserStats(usersRes.data);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Box>
      <Box sx={{ mb: 4 }}>
        <Typography variant="h4" gutterBottom>
          Dashboard Overview
        </Typography>
        <ButtonGroup variant="outlined" size="small">
          <Button
            onClick={() => setPeriod('week')}
            variant={period === 'week' ? 'contained' : 'outlined'}
          >
            Week
          </Button>
          <Button
            onClick={() => setPeriod('month')}
            variant={period === 'month' ? 'contained' : 'outlined'}
          >
            Month
          </Button>
          <Button
            onClick={() => setPeriod('year')}
            variant={period === 'year' ? 'contained' : 'outlined'}
          >
            Year
          </Button>
        </ButtonGroup>
      </Box>

      <Grid container spacing={3}>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Total Users"
            value={stats?.totalUsers}
            icon={<PeopleIcon color="primary" />}
            trend={stats?.userGrowth}
            loading={loading}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Total Balance"
            value={`$${stats?.totalBalance.toLocaleString()}`}
            icon={<AccountBalanceIcon color="success" />}
            trend={stats?.balanceGrowth}
            loading={loading}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Active Cards"
            value={stats?.activeCards}
            icon={<CreditCardIcon color="info" />}
            trend={stats?.cardGrowth}
            loading={loading}
          />
        </Grid>
        <Grid item xs={12} sm={6} md={3}>
          <StatCard
            title="Total Transactions"
            value={stats?.totalTransactions}
            icon={<TrendingUpIcon color="warning" />}
            trend={stats?.transactionGrowth}
            loading={loading}
          />
        </Grid>

        <Grid item xs={12} md={8}>
          <Card sx={{ height: 400 }}>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Transaction Volume
              </Typography>
              {loading ? (
                <Box
                  sx={{
                    height: '100%',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  <CircularProgress />
                </Box>
              ) : (
                <Box sx={{ height: 350 }}>
                  <ResponsiveLine
                    data={transactionData?.volumeData || []}
                    margin={{ top: 20, right: 20, bottom: 50, left: 60 }}
                    xScale={{ type: 'point' }}
                    yScale={{ type: 'linear', min: 'auto', max: 'auto' }}
                    axisTop={null}
                    axisRight={null}
                    axisBottom={{
                      tickSize: 5,
                      tickPadding: 5,
                      tickRotation: 0,
                    }}
                    axisLeft={{
                      tickSize: 5,
                      tickPadding: 5,
                      tickRotation: 0,
                    }}
                    pointSize={10}
                    pointColor={{ theme: 'background' }}
                    pointBorderWidth={2}
                    pointBorderColor={{ from: 'serieColor' }}
                    enablePointLabel={true}
                    pointLabel="y"
                    pointLabelYOffset={-12}
                    useMesh={true}
                  />
                </Box>
              )}
            </CardContent>
          </Card>
        </Grid>

        <Grid item xs={12} md={4}>
          <Card sx={{ height: 400 }}>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Transaction Types
              </Typography>
              {loading ? (
                <Box
                  sx={{
                    height: '100%',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                  }}
                >
                  <CircularProgress />
                </Box>
              ) : (
                <Box sx={{ height: 350 }}>
                  <ResponsivePie
                    data={transactionData?.typeData || []}
                    margin={{ top: 20, right: 20, bottom: 20, left: 20 }}
                    innerRadius={0.5}
                    padAngle={0.7}
                    cornerRadius={3}
                    activeOuterRadiusOffset={8}
                    borderWidth={1}
                    borderColor={{ from: 'color', modifiers: [['darker', 0.2]] }}
                    arcLinkLabelsSkipAngle={10}
                    arcLinkLabelsTextColor="#333333"
                    arcLinkLabelsThickness={2}
                    arcLinkLabelsColor={{ from: 'color' }}
                    arcLabelsSkipAngle={10}
                    arcLabelsTextColor="#ffffff"
                  />
                </Box>
              )}
            </CardContent>
          </Card>
        </Grid>
      </Grid>
    </Box>
  );
} 