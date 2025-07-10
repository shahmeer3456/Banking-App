import React, { useState, useEffect } from 'react';
import {
    Box,
    Table,
    Thead,
    Tbody,
    Tr,
    Th,
    Td,
    IconButton,
    useToast,
    Button,
    Modal,
    ModalOverlay,
    ModalContent,
    ModalHeader,
    ModalBody,
    ModalFooter,
    useDisclosure,
    FormControl,
    FormLabel,
    Input,
    Stack,
    Badge
} from '@chakra-ui/react';
import { FiEdit2, FiTrash2, FiEye } from 'react-icons/fi';
import { adminApi } from '../services/api';

const Users = () => {
    const [users, setUsers] = useState([]);
    const [selectedUser, setSelectedUser] = useState(null);
    const [loading, setLoading] = useState(true);
    const { isOpen, onOpen, onClose } = useDisclosure();
    const toast = useToast();

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        try {
            const data = await adminApi.getUsers();
            setUsers(data);
            setLoading(false);
        } catch (error) {
            toast({
                title: 'Error fetching users',
                description: error.message,
                status: 'error',
                duration: 3000,
                isClosable: true,
            });
            setLoading(false);
        }
    };

    const handleEdit = (user) => {
        setSelectedUser(user);
        onOpen();
    };

    const handleUpdate = async (e) => {
        e.preventDefault();
        try {
            await adminApi.updateUser(selectedUser._id, selectedUser);
            toast({
                title: 'User updated',
                status: 'success',
                duration: 3000,
                isClosable: true,
            });
            onClose();
            fetchUsers();
        } catch (error) {
            toast({
                title: 'Error updating user',
                description: error.message,
                status: 'error',
                duration: 3000,
                isClosable: true,
            });
        }
    };

    const handleDelete = async (userId) => {
        if (window.confirm('Are you sure you want to delete this user?')) {
            try {
                await adminApi.deleteUser(userId);
                toast({
                    title: 'User deleted',
                    status: 'success',
                    duration: 3000,
                    isClosable: true,
                });
                fetchUsers();
            } catch (error) {
                toast({
                    title: 'Error deleting user',
                    description: error.message,
                    status: 'error',
                    duration: 3000,
                    isClosable: true,
                });
            }
        }
    };

    return (
        <Box p={4}>
            <Table variant="simple">
                <Thead>
                    <Tr>
                        <Th>Name</Th>
                        <Th>Email</Th>
                        <Th>Account Number</Th>
                        <Th>Status</Th>
                        <Th>Actions</Th>
                    </Tr>
                </Thead>
                <Tbody>
                    {users.map((user) => (
                        <Tr key={user._id}>
                            <Td>{user.name}</Td>
                            <Td>{user.email}</Td>
                            <Td>{user.accountNumber}</Td>
                            <Td>
                                <Badge
                                    colorScheme={user.status === 'active' ? 'green' : 'red'}
                                >
                                    {user.status}
                                </Badge>
                            </Td>
                            <Td>
                                <IconButton
                                    aria-label="Edit user"
                                    icon={<FiEdit2 />}
                                    mr={2}
                                    onClick={() => handleEdit(user)}
                                />
                                <IconButton
                                    aria-label="Delete user"
                                    icon={<FiTrash2 />}
                                    colorScheme="red"
                                    onClick={() => handleDelete(user._id)}
                                />
                            </Td>
                        </Tr>
                    ))}
                </Tbody>
            </Table>

            <Modal isOpen={isOpen} onClose={onClose}>
                <ModalOverlay />
                <ModalContent>
                    <ModalHeader>Edit User</ModalHeader>
                    <ModalBody>
                        <Stack spacing={4}>
                            <FormControl>
                                <FormLabel>Name</FormLabel>
                                <Input
                                    value={selectedUser?.name || ''}
                                    onChange={(e) =>
                                        setSelectedUser({
                                            ...selectedUser,
                                            name: e.target.value,
                                        })
                                    }
                                />
                            </FormControl>
                            <FormControl>
                                <FormLabel>Email</FormLabel>
                                <Input
                                    value={selectedUser?.email || ''}
                                    onChange={(e) =>
                                        setSelectedUser({
                                            ...selectedUser,
                                            email: e.target.value,
                                        })
                                    }
                                />
                            </FormControl>
                            <FormControl>
                                <FormLabel>Status</FormLabel>
                                <select
                                    value={selectedUser?.status || ''}
                                    onChange={(e) =>
                                        setSelectedUser({
                                            ...selectedUser,
                                            status: e.target.value,
                                        })
                                    }
                                >
                                    <option value="active">Active</option>
                                    <option value="inactive">Inactive</option>
                                    <option value="blocked">Blocked</option>
                                </select>
                            </FormControl>
                        </Stack>
                    </ModalBody>
                    <ModalFooter>
                        <Button colorScheme="blue" mr={3} onClick={handleUpdate}>
                            Save
                        </Button>
                        <Button onClick={onClose}>Cancel</Button>
                    </ModalFooter>
                </ModalContent>
            </Modal>
        </Box>
    );
};

export default Users; 