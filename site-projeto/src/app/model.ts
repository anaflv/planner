export class Customer {
    id: number;
    name: string;
    address: Address;
  }
  
  export class Address {
    street: string;
    city: string;
    state: string;
    region: string;
  }

  export class UserData {

    bi: string;
    postBi: number;
    classes: string;

  }

  export interface Course {
    
    codigo: string;
  }
