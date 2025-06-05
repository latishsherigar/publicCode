import React from 'react';
import { View, Text, StyleSheet } from 'react-native';

const MyComponent = () => {
    return (
        <View style={styles.container}>
            <Text style={styles.text}>Hello from MyComponent!</Text>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    text: {
        fontSize: 20,
        color: '#333',
    },
});

export default MyComponent;