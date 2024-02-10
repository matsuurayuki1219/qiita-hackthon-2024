import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Put,
  Request,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { AuthGuard } from 'src/auth/auth-guard/auth-guard.guard';
import { PostPriseRequest } from 'src/request_models/post-praise-request/post-praise-request';
import { PrivateRequest } from 'src/request_models/private-request/private-request';
import { PraiseService } from 'src/services/praise/praise.service';
import { UserService } from 'src/services/user/user.service';
import { PutComment } from 'src/request_models/put-comment/put-comment';
import { PutStamp } from 'src/request_models/put-stamp/put-stamp';
import { CurrentPraiseResponse } from 'src/view_models/current-praise/current-praise';
import { PraiseResponse } from 'src/view_models/praise-response/praise-response';
import { StampResponse } from 'src/view_models/stamp-response/stamp-response';
import { CommentResponse } from 'src/view_models/comment-response/comment-response';

@ApiBearerAuth()
@ApiTags('praise')
@UseGuards(AuthGuard)
@Controller('praise')
export class PrisesController {
  constructor(
    private priseService: PraiseService,
    private userService: UserService,
  ) {}
  @Post('/')
  @ApiCreatedResponse({
    description: 'The record has been successfully created.',
    type: PraiseResponse,
  })
  async postPraise(
    @Request() req: PrivateRequest,
    @Body() body: PostPriseRequest,
  ) {
    const from_user_id = (req.user as any).sub;
    const praise = await this.priseService.postPraise({
      description: body.description,
      from_user_id: from_user_id,
      to_user_id: body.to_user_id,
    });
    await this.userService.switchStatus(body.to_user_id);
    return PraiseResponse.fromEntity(praise);
  }

  @Get('/current_praise')
  @ApiOkResponse({
    description: 'The record has been successfully created.',
    type: CurrentPraiseResponse,
  })
  @ApiNotFoundResponse({
    description: 'Not found',
  })
  async currentPraise() {
    const currentPraise = await this.priseService.getCurrentPraise();
    return new CurrentPraiseResponse(currentPraise);
  }

  @Put('/:praise_id/comment')
  @ApiCreatedResponse({
    type: CommentResponse,
  })
  @ApiNotFoundResponse()
  async putComment(
    @Request() req: PrivateRequest,
    @Param('praise_id') praise_id: number,
    @Body() body: PutComment,
  ) {
    const from_user_id = req.user.id;
    return this.priseService.putComment(praise_id, {
      from_user_id: from_user_id,
      comment: body.comment,
    });
  }

  @Put('/:praise_id/stamp')
  @ApiCreatedResponse({
    type: StampResponse,
  })
  @ApiNotFoundResponse()
  async putStamp(
    @Request() req: PrivateRequest,
    @Param('praise_id') praise_id: number,
    @Body() body: PutStamp,
  ) {
    const from_user_id = req.user.id;
    return this.priseService.putStamp(praise_id, {
      from_user_id: from_user_id,
      stamp: body.stamp,
    });
  }
}
