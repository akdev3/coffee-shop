import React, { useState, useEffect } from "react";
import Table from 'react-bootstrap/Table';
import { Form, Button, Dropdown, DropdownButton, Spinner, Toast, Container } from "react-bootstrap";
import { get, post } from '../api';

const Home = () => {
  const [selectedData, setSelectedData] = useState("");

  const [items, setItems] = useState([]);
  const [groupItems, setGroupItems] = useState([]);
  const [promotionLineItems, setPromotionLineItems] = useState([]);
  const [selectedItem, setSelectedItem] = useState({});
  const [allItems, setAllItems] = useState([]);

  const [discount, setDiscount] = useState(0);
  const [quantity, setQuantity] = useState(1);

  const [IsLoader, setIsLoader] = useState(false);

  const [toast, setToast] = useState({});

  useEffect(() => {
    try {
      async function fetchData() {
        const itemsData = await get('items');
        const groupItemsData = await get('group_items');
        const promotionItemsData = await get('promotion_line_items');

        setItems(itemsData);
        setGroupItems(groupItemsData);
        setPromotionLineItems(promotionItemsData);
      }
      fetchData()
    } catch (error) {
      console.log('error ', error)
    }
  }, []);

  const handleDataSelection = (dataType) => {
    setSelectedData(dataType);
  }

  const handlePlaceOrder = async() => {
    try {
      setIsLoader(true)
      const payload = {
        customer_id: 1,
        'line_items': allItems
      }
      await post('orders', payload);

      setIsLoader(false);
      setAllItems([]);
      setToast({
        success: 'success',
        header: 'Order Confirmation',
        message: 'You Order Has Been Placed Successfully!',
        display: true
      });
      setTimeout(() => {
        setToast({});
      }, 3000);
    } catch (error) {
      console.error('Error:', error);
      setIsLoader(false)
      setToast({
        success: 'danger',
        header: 'Oops',
        message: 'Something went wrong, please try later!',
        display: true
      })
      setTimeout(() => {
        setToast({});
      }, 3000);
    }
  }

  const handleItemSelectionFromDD = ({category, index}) => {
    let item = {}
    if (category === 'item') {
      item = items[index]
    } else if (category === 'groupItem') {
      item = groupItems[index]
      item.price = (item?.items || []).reduce((acc, item) => {
        return acc + parseInt(item.price);
      }, 0);
    } else if (category === 'promotionLineItem') {
      item = promotionLineItems[index]
      item.name = `Buy ${item.source_item.name} and get ${item.dest_item.name} free`
      item.price = item.source_item.price
    }
    item.category = category
    setSelectedItem(item)
  }

  const addToCart = () => {
    const newItem = {
      name: selectedItem.name,
      price: selectedItem.price
    };

    if (selectedItem.category === 'item') {
      newItem.item_id = selectedItem.id
      newItem.disc = discount
    } else if (selectedItem.category === 'groupItem') {
      newItem.group_item_id = selectedItem.id
      newItem.price = (selectedItem?.items || []).reduce((acc, item) => {
        return acc + parseInt(item.price);
      }, 0);
      newItem.disc = selectedItem.disc_amount
    } else if (selectedItem.category === 'promotionLineItem') {
      newItem.promotion_line_item = selectedItem.id
      newItem.price = selectedItem.source_item.price
      newItem.promotion_line_item_id = selectedItem.id
    }
    newItem.quantity = quantity;

    setAllItems([...allItems, newItem])
    setSelectedItem({})
    setQuantity(1)
  }

  const getItemsPrice = (isDiscountedAmount) => {
    const amount = allItems.reduce((acc, item) => {
      return (acc + (isDiscountedAmount ? (item.disc || 0) : (item.price || 0)) * (item.quantity || 0) || acc)
    }, 0)
    return amount;
  }

  return (
    <Container>
      <Toast 
        bg={toast.success}
        className="position-fixed top-0 end-0 m-3"
        show={!!toast.display}
        onClose={() => setToast({})}>
        <Toast.Header>
          <strong className="me-auto">{toast.header}</strong>
        </Toast.Header>
        <Toast.Body>{toast.message}</Toast.Body>
      </Toast>
      {IsLoader && 
        <div className="spinner">
          <Spinner animation="border" variant="light" />
        </div>
      }
      <div className="text-center">
        <h1 className="text-muted">Coffee Shop</h1>
      </div>
      <div className="d-flex justify-content-center">
        <Button
          variant="outline-primary"
          onClick={() => handleDataSelection("items")}
          className="mx-2 my-2"
        >
          Order Item
        </Button>
        <Button
          variant="outline-secondary"
          onClick={() => handleDataSelection("group_items")}
          className="mx-2 my-2"
        >
          Order Group Item
        </Button>
        <Button
          variant="outline-info"
          onClick={() => handleDataSelection("promotion_line_items")}
          className="mx-2 my-2"
        >
          Order Promotion Line Item
        </Button>
      </div>
      <Form>
        {selectedData === "items" && (
          <div className="d-flex align-items-center justify-content-center h-100">
            <Form.Group controlId="formBasicItems">            
              <DropdownButton
                id="dropdown-basic-button"
                title="Select Item"
                className="mt-3"
              >
                {items.map((item, index) => (
                    <Dropdown.Item
                      key={item.id}
                      onClick={() =>{
                        const params = {
                          index,
                          category: 'item'
                        }
                        handleItemSelectionFromDD(params)
                      }
                    }
                    >
                      {item.name}
                    </Dropdown.Item>
                ))}
              </DropdownButton>
            </Form.Group>
          </div>
        )}
      
        {selectedData === "group_items" && (
          <div className="d-flex align-items-center justify-content-center h-100">
            <Form.Group controlId="formBasicGroupItems">
              <DropdownButton
                id="dropdown-basic-button"
                title="Select Group Item"
                className="mt-3"
              >
                {groupItems.map((groupItem, index) => (
                  <Dropdown.Item
                    key={groupItem.id}
                    onClick={() => {
                      const params = {
                        index,
                        category: 'groupItem'
                      }
                      handleItemSelectionFromDD(params)
                    }
                  }
                  >
                    {groupItem.name}
                  </Dropdown.Item>
                ))}
              </DropdownButton>
            </Form.Group>
          </div>
        )}
      
        {selectedData === "promotion_line_items" && (
          <div className="d-flex align-items-center justify-content-center h-100">
            <Form.Group controlId="formBasicPromotionLineItems">
              <DropdownButton
                id="dropdown-basic-button"
                title="Select Promotion Line Item"
                 className="mt-3"
              >
                {promotionLineItems.map((promotionLineItem, index) => (
                  <Dropdown.Item
                    key={index}
                    onClick={() => {
                      const params = {
                        index,
                        category: 'promotionLineItem'
                      }
                      handleItemSelectionFromDD(params)
                    }
                    }
                  >
                    Buy {promotionLineItem.source_item.name}, Get {promotionLineItem.dest_item.name} free
                  </Dropdown.Item>
                ))}
              </DropdownButton>
            </Form.Group>
          </div>
        )}

        {selectedItem.name &&
          <div>
            <div className="font-size"><span className="selected-item-styling">Name: </span>{selectedItem.name}</div>
            <div className="font-size"><span className="selected-item-styling">Price: </span>${selectedItem.price}</div>
            <Form.Group>
              <Form.Label className="font-size selected-item-styling">Quantity:</Form.Label>
              <div className="font-size selected-item-styling">
                <Button variant="secondary" onClick={()=> setQuantity(quantity + 1)}>
                  +
                </Button>
                <span className="quantity">{quantity}</span>
                <Button variant="secondary" onClick={()=> {
                  if (quantity > 1) {
                    setQuantity(quantity - 1)
                  }
                }}>
                  -
                </Button>
              </div>
              {selectedData === "items" && 
              <>
                <Form.Label className="font-size selected-item-styling">Discount</Form.Label>
                <Form.Control type="number" placeholder="Enter Discount" value={discount} onChange={(e)=> {
                  if (e.target.value >= 0) {
                    setDiscount(e.target.value)
                  }
                }}/>
              </>
              }
            </Form.Group>
            <Button className="mt-2" variant="info" onClick={addToCart}>
              Add to cart
            </Button>
          </div>
        }
      </Form>
      {allItems.length > 0 ? (
        <div>
          Cart
          <Table striped bordered hover>
            <thead>
              <tr>
                <th>#</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Discount</th>
              </tr>
            </thead>
            <tbody>
              {allItems.map((item, index) => {
                return (
                  <tr key={index}>
                    <td>{index+1}</td>
                    <td>{item.name}</td>
                    <td>{item.quantity}</td>
                    <td>${item.price * item.quantity}</td>
                    <td>${item.disc ? item.disc * item.quantity : 0}</td>
                  </tr>
                )
              })}
              <tr>
                <td>
                  Total Amount
                </td>
                <td colSpan={4}>
                  {
                    allItems.map((item, index) => {
                      let sign = ''
                      if (index < allItems.length - 1) {
                        sign = ' + '
                      }
                      return `$${(item.price * item.quantity || 0)}${sign}`
                    })
                  }
                  -
                  $
                  {getItemsPrice(true)}
                  =

                  $
                  {getItemsPrice(false) - getItemsPrice(true)}
                </td>
              </tr>
            </tbody>
          </Table>
          <Button className="mt-2" variant="success" onClick={handlePlaceOrder}>
              Place Order
            </Button>
        </div>
      ) : <div className="fixed-top w-100 h-100 d-flex align-items-center justify-content-center nothing-cart-text">
            <h1 className="text-center">There is nothing in your cart.</h1>
          </div>
      }
    </Container>
)}
export default Home
