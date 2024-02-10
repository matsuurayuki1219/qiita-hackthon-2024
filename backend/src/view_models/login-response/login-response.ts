import { ApiProperty } from '@nestjs/swagger';
import { User } from 'src/models/user/user';

export class LoginResponse extends User {
  @ApiProperty({
    example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
    description: 'The access token of the User',
  })
  access_token: string;
}
