import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { UserService } from 'src/services/user/user.service';
import { UserResponse } from 'src/view_models/user-response/user-response';

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(private userService: UserService) {}
  @Get('/')
  @ApiOperation({ summary: 'Get all users' })
  @ApiOkResponse({
    type: UserResponse,
    isArray: true,
  })
  async getUsers() {
    const users = await this.userService.getUsers();
    return users.map(UserResponse.fromEntity);
  }
}
