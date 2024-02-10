import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { User } from 'src/models/user/user';

@ApiTags('users')
@Controller('users')
export class UsersController {
  @Get('/')
  @ApiOperation({ summary: 'Get all users' })
  @ApiOkResponse({
    type: User,
    isArray: true,
  })
  getUsers() {
    return [
      {
        id: 1,
        name: 'John Doe',
      },
    ];
  }
}
